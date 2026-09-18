/*
 * web_api.c
 *
 * JSON HTTP API over esp_http_server. See web_api.h for the endpoint list.
 *
 * Fixed-size responses are built into s_resp with json_min.c and sent in one
 * shot. The three whose size grows with the data - /api/status, /api/results
 * and /api/catalog - use the same buffer but flush it between array elements
 * (see chunk_begin/chunk_flush/chunk_end), so none of them is bounded by
 * RESP_BUF.
 */

#include <string.h>
#include <stdio.h>
#include <stdlib.h>
#include "esp_log.h"
#include "esp_http_server.h"
#include "esp_timer.h"

#include "web_api.h"
#include "wifi_mgr.h"
#include "json_min.h"
#include "test_engine.h"
#include "result_store.h"
#include "cell_profiles.h"
#include "bts_link.h"

static const char *TAG = "web_api";

#define RESP_BUF        6144
#define REQ_BUF         1024
#define RESULTS_PAGE    10

static httpd_handle_t s_server;
static char           s_resp[RESP_BUF];

/* ------------------------------------------------------------------ */
/* Helpers                                                            */
/* ------------------------------------------------------------------ */

static esp_err_t send_json(httpd_req_t *req, const json_out_t *j)
{
    if (!json_ok(j)) {
        ESP_LOGE(TAG, "response truncated for %s", req->uri);
        httpd_resp_set_status(req, "500 Internal Server Error");
        httpd_resp_set_type(req, "application/json");
        return httpd_resp_sendstr(req, "{\"error\":\"response too large\"}");
    }
    httpd_resp_set_type(req, "application/json");
    /*
     * The tester is a LAN appliance and the web UI is served from elsewhere
     * (a file, or a dev server), so a browser reaching it cross-origin is
     * the normal case rather than the exception.
     */
    httpd_resp_set_hdr(req, "Access-Control-Allow-Origin", "*");
    return httpd_resp_send(req, j->buf, j->len);
}

/*
 * Chunked sending, for the responses whose size grows with the data.
 *
 * /api/status at eight configured slots, and /api/results at a full page,
 * both exceed RESP_BUF. Rather than size a static buffer for the worst case
 * on a device with one heap, these emit into the same buffer and flush it
 * whenever it fills. json_drain() keeps the separator state, so the
 * document continues across a flush.
 *
 * Call chunk_begin() before emitting, chunk_flush() at safe points (between
 * array elements), and chunk_end() to finish the response.
 */
static void chunk_begin(httpd_req_t *req, json_out_t *j)
{
    httpd_resp_set_type(req, "application/json");
    httpd_resp_set_hdr(req, "Access-Control-Allow-Origin", "*");
    json_init(j, s_resp, sizeof(s_resp));
}

static esp_err_t chunk_flush(httpd_req_t *req, json_out_t *j)
{
    if (j->overflow) {
        /*
         * A single element was larger than the whole buffer. Nothing useful
         * can be sent, and the chunked response is already committed, so
         * close it out and let the client see a short read.
         */
        ESP_LOGE(TAG, "element exceeds the response buffer for %s", req->uri);
        return ESP_FAIL;
    }
    if (j->len == 0) {
        return ESP_OK;
    }
    const esp_err_t err = httpd_resp_send_chunk(req, j->buf, j->len);
    json_drain(j);
    return err;
}

static esp_err_t chunk_end(httpd_req_t *req, json_out_t *j)
{
    esp_err_t err = chunk_flush(req, j);
    if (err != ESP_OK) {
        /* Terminating chunk regardless, so the connection is not left open. */
        httpd_resp_send_chunk(req, NULL, 0);
        return err;
    }
    return httpd_resp_send_chunk(req, NULL, 0);
}

static esp_err_t send_error(httpd_req_t *req, const char *status, const char *msg)
{
    char body[160];
    json_out_t j;
    json_init(&j, body, sizeof(body));
    json_obj_open(&j, NULL);
    json_kv_bool(&j, "ok", false);
    json_kv_str(&j, "error", msg);
    json_obj_close(&j);

    httpd_resp_set_status(req, status);
    httpd_resp_set_type(req, "application/json");
    httpd_resp_set_hdr(req, "Access-Control-Allow-Origin", "*");
    return httpd_resp_send(req, j.buf, j.len);
}

static esp_err_t send_ok(httpd_req_t *req)
{
    char body[32];
    json_out_t j;
    json_init(&j, body, sizeof(body));
    json_obj_open(&j, NULL);
    json_kv_bool(&j, "ok", true);
    json_obj_close(&j);
    return send_json(req, &j);
}

/*
 * Copies a NUL-terminated string into a fixed field, refusing rather than
 * truncating. Returns false when it does not fit.
 */
static bool copy_field(char *dst, size_t dst_len, const char *src)
{
    const size_t n = strlen(src);
    if (n >= dst_len) {
        return false;
    }
    memcpy(dst, src, n + 1);
    return true;
}

/* Reads the request body into buf. Returns the length, or -1. */
static int read_body(httpd_req_t *req, char *buf, size_t cap)
{
    if (req->content_len == 0) {
        buf[0] = '\0';
        return 0;
    }
    if (req->content_len >= cap) {
        return -1;
    }

    size_t got = 0;
    while (got < req->content_len) {
        const int n = httpd_req_recv(req, buf + got, req->content_len - got);
        if (n <= 0) {
            return -1;
        }
        got += (size_t)n;
    }
    buf[got] = '\0';
    return (int)got;
}

/*
 * Extracts the slot number from a URI of the form /api/slot/<n>/... .
 *
 * Returns -1 when the segment is missing or out of range, so every handler
 * has one check rather than trusting a wildcard match.
 */
static int slot_from_uri(const char *uri)
{
    const char *p = strstr(uri, "/slot/");
    if (p == NULL) {
        return -1;
    }
    p += 6;
    if (*p < '0' || *p > '9') {
        return -1;
    }
    const int slot = atoi(p);
    return (slot >= 0 && slot < SLOT_COUNT) ? slot : -1;
}

/* Query parameter as an unsigned, or `fallback`. */
static uint32_t query_u32(httpd_req_t *req, const char *key, uint32_t fallback)
{
    char query[96];
    char value[16];
    if (httpd_req_get_url_query_str(req, query, sizeof(query)) != ESP_OK) {
        return fallback;
    }
    if (httpd_query_key_value(query, key, value, sizeof(value)) != ESP_OK) {
        return fallback;
    }
    return (uint32_t)strtoul(value, NULL, 10);
}

/* ------------------------------------------------------------------ */
/* Serialisers                                                        */
/* ------------------------------------------------------------------ */

static void emit_profile(json_out_t *j, const cell_resolved_profile_t *p)
{
    json_obj_open(j, "profile");
    json_kv_str(j, "chemistry", cell_chemistry_name(p->chemistry));
    json_kv_str(j, "model", p->model_name);
    json_kv_f(j, "capacity_mah", p->capacity_mah, 0);
    json_kv_f(j, "charge_v_max", p->charge_v_max, 3);
    json_kv_f(j, "discharge_v_min", p->discharge_v_min, 3);
    json_kv_f(j, "storage_v", p->storage_v, 3);
    json_kv_f(j, "charge_current_a", p->charge_current_a, 3);
    json_kv_f(j, "discharge_current_a", p->discharge_current_a, 3);
    json_kv_f(j, "charge_term_current_a", p->charge_term_current_a, 3);
    json_kv_f(j, "temp_min_c", p->temp_min_c, 1);
    json_kv_f(j, "temp_max_c", p->temp_max_c, 1);
    json_kv_f(j, "rest_tolerance_pct", p->rest_tolerance_pct, 1);
    json_kv_u(j, "rest_minutes", p->rest_minutes);
    json_obj_close(j);
}

static void emit_result(json_out_t *j, const char *key, const slot_result_t *r)
{
    json_obj_open(j, key);
    json_kv_bool(j, "valid", r->valid);
    if (!r->valid) {
        json_obj_close(j);
        return;
    }
    json_kv_str(j, "serial", r->serial);
    json_kv_str(j, "model", r->model_name);
    json_kv_str(j, "chemistry", cell_chemistry_name(r->chemistry));
    json_kv_f(j, "start_voltage_v", r->start_voltage_v, 3);
    json_kv_f(j, "end_voltage_v", r->end_voltage_v, 3);
    json_kv_f(j, "rested_voltage_v", r->rested_voltage_v, 3);
    json_kv_f(j, "discharge_mah", r->discharge_mah, 1);
    json_kv_f(j, "discharge_mwh", r->discharge_mwh, 1);
    json_kv_f(j, "max_temp_c", r->max_temp_c, 1);
    json_kv_f(j, "max_current_a", r->max_current_a, 3);
    json_kv_f(j, "min_voltage_v", r->min_voltage_v, 3);
    json_kv_f(j, "max_voltage_v", r->max_voltage_v, 3);
    json_kv_u(j, "discharge_seconds", r->discharge_seconds);
    json_kv_bool(j, "recharged", r->recharged);
    json_kv_f(j, "recharge_mah", r->recharge_mah, 1);
    json_kv_f(j, "shipping_voltage_v", r->shipping_voltage_v, 3);
    /*
     * Raw BTS accumulators. Zero unless a future BTS build populates them -
     * see bts_link_stats_are_live(). Reported so a comparison against the
     * locally integrated figures is possible without a firmware change here.
     */
    json_obj_open(j, "bts_raw");
    json_kv_bool(j, "live", bts_link_stats_are_live());
    json_kv_f(j, "current_acc", r->bts_current_acc, 3);
    json_kv_f(j, "power_acc", r->bts_power_acc, 3);
    json_obj_close(j);
    json_kv_i(j, "completed_uptime_s", r->completed_unix);
    json_obj_close(j);
}

static void emit_slot(json_out_t *j, uint8_t slot, const slot_status_t *st,
                      bool include_result)
{
    json_obj_open(j, NULL);
    json_kv_u(j, "slot", slot);
    json_kv_str(j, "state", slot_state_name(st->state));
    json_kv_str(j, "fault", slot_fault_name(st->fault));
    json_kv_bool(j, "configured", st->configured);
    json_kv_f(j, "voltage_v", st->voltage_v, 3);
    json_kv_f(j, "current_a", st->current_a, 3);
    json_kv_f(j, "temp_c", st->temp_c, 1);
    json_kv_f(j, "live_mah", (float)st->live_mah, 1);
    json_kv_f(j, "live_mwh", (float)st->live_mwh, 1);
    json_kv_f(j, "progress", st->progress, 3);
    json_kv_u(j, "elapsed_s", st->elapsed_s);
    json_kv_u(j, "state_elapsed_s", st->state_elapsed_s);
    json_kv_u(j, "bts_status", st->status_bits);
    json_kv_str(j, "serial", st->config.serial);

    if (st->configured) {
        json_obj_open(j, "config");
        json_kv_str(j, "chemistry", cell_chemistry_name(st->config.chemistry));
        json_kv_str(j, "model", st->config.model_name);
        json_kv_f(j, "capacity_mah", st->config.capacity_mah, 0);
        json_kv_f(j, "charge_c", st->config.charge_c, 2);
        json_kv_f(j, "discharge_c", st->config.discharge_c, 2);
        json_kv_bool(j, "auto_recharge_to_shipping",
                     st->config.auto_recharge_to_shipping);
        json_kv_f(j, "shipping_pct", st->config.shipping_pct, 1);
        json_kv_u(j, "max_duration_minutes", st->config.max_duration_minutes);
        json_obj_close(j);
        emit_profile(j, &st->profile);
    }

    if (include_result) {
        emit_result(j, "last_result", &st->last_result);
    }
    json_obj_close(j);
}

static void emit_unit(json_out_t *j)
{
    bts_snapshot_t snap;
    bts_link_get_snapshot(&snap);

    json_obj_open(j, "unit");
    json_kv_bool(j, "online", snap.unit.online);
    json_kv_u(j, "unit_state", (uint32_t)snap.unit.unit_state);
    json_kv_f(j, "input_voltage_v", snap.unit.input_voltage_v, 3);
    json_kv_u(j, "trip_status", snap.unit.trip_status);
    json_kv_u(j, "consecutive_errors", snap.unit.consecutive_errors);
    json_kv_u(j, "slots", SLOT_COUNT);
    json_kv_f(j, "max_current_a", BTS_UNIT_MAX_CURRENT_A, 1);
    json_kv_f(j, "max_voltage_v", BTS_UNIT_MAX_VOLTAGE_V, 1);
    json_kv_bool(j, "bts_accumulators_live", bts_link_stats_are_live());
    json_kv_u(j, "uptime_s", (uint32_t)(esp_timer_get_time() / 1000000));
    json_kv_bool(j, "wifi_sta", wifi_mgr_connected());
    json_kv_bool(j, "wifi_ap", wifi_mgr_ap_active());
    json_obj_close(j);
}

/* ------------------------------------------------------------------ */
/* Handlers                                                           */
/* ------------------------------------------------------------------ */

static esp_err_t h_status(httpd_req_t *req)
{
    json_out_t j;
    chunk_begin(req, &j);

    json_obj_open(&j, NULL);
    emit_unit(&j);
    json_arr_open(&j, "slots");
    for (uint8_t slot = 0; slot < SLOT_COUNT; slot++) {
        slot_status_t st;
        test_engine_get_status(slot, &st);
        /* Results are omitted here to keep the poll response small; fetch
         * them per slot or from /api/results. */
        emit_slot(&j, slot, &st, false);
        if (chunk_flush(req, &j) != ESP_OK) {
            return httpd_resp_send_chunk(req, NULL, 0);
        }
    }
    json_arr_close(&j);
    json_obj_close(&j);

    return chunk_end(req, &j);
}

static esp_err_t h_slot_get(httpd_req_t *req)
{
    const int slot = slot_from_uri(req->uri);
    if (slot < 0) {
        return send_error(req, "404 Not Found", "bad slot");
    }

    slot_status_t st;
    test_engine_get_status((uint8_t)slot, &st);

    json_out_t j;
    json_init(&j, s_resp, sizeof(s_resp));
    emit_slot(&j, (uint8_t)slot, &st, true);
    return send_json(req, &j);
}

static esp_err_t h_slot_result(httpd_req_t *req)
{
    const int slot = slot_from_uri(req->uri);
    if (slot < 0) {
        return send_error(req, "404 Not Found", "bad slot");
    }

    slot_result_t r;
    memset(&r, 0, sizeof(r));
    (void)test_engine_get_result((uint8_t)slot, &r);

    json_out_t j;
    json_init(&j, s_resp, sizeof(s_resp));
    json_obj_open(&j, NULL);
    json_kv_u(&j, "slot", (uint32_t)slot);
    emit_result(&j, "result", &r);
    json_obj_close(&j);
    return send_json(req, &j);
}

static esp_err_t h_slot_config(httpd_req_t *req)
{
    const int slot = slot_from_uri(req->uri);
    if (slot < 0) {
        return send_error(req, "404 Not Found", "bad slot");
    }

    char body[REQ_BUF];
    const int len = read_body(req, body, sizeof(body));
    if (len < 0) {
        return send_error(req, "400 Bad Request", "body too large");
    }

    /*
     * Start from the slot's current configuration so a POST can change one
     * field. A bench UI sending only {"serial":"..."} should not silently
     * reset the chemistry.
     */
    slot_status_t st;
    test_engine_get_status((uint8_t)slot, &st);
    slot_config_t cfg = st.config;

    char   sbuf[64];
    double num;
    bool   flag;

    if (json_get_str(body, (size_t)len, "chemistry", sbuf, sizeof(sbuf))) {
        cell_chemistry_t chem;
        if (!cell_chemistry_from_name(sbuf, &chem)) {
            return send_error(req, "400 Bad Request", "unknown chemistry");
        }
        cfg.chemistry = chem;
    }
    if (json_get_str(body, (size_t)len, "model", sbuf, sizeof(sbuf))) {
        if (sbuf[0] != '\0' && cell_model_find(sbuf) == NULL) {
            return send_error(req, "400 Bad Request", "unknown model");
        }
        if (!copy_field(cfg.model_name, sizeof(cfg.model_name), sbuf)) {
            return send_error(req, "400 Bad Request", "model name too long");
        }
    }
    if (json_get_str(body, (size_t)len, "serial", sbuf, sizeof(sbuf))) {
        /*
         * Rejected rather than truncated: a half-written barcode on a test
         * record is worse than a failed scan, because it looks like a
         * genuine serial.
         */
        if (!copy_field(cfg.serial, sizeof(cfg.serial), sbuf)) {
            return send_error(req, "400 Bad Request", "serial too long");
        }
    }
    if (json_get_num(body, (size_t)len, "capacity_mah", &num)) {
        cfg.capacity_mah = (float)num;
    }
    if (json_get_num(body, (size_t)len, "charge_c", &num)) {
        cfg.charge_c = (float)num;
    }
    if (json_get_num(body, (size_t)len, "discharge_c", &num)) {
        cfg.discharge_c = (float)num;
    }
    if (json_get_num(body, (size_t)len, "shipping_pct", &num)) {
        if (num <= 0.0 || num > 100.0) {
            return send_error(req, "400 Bad Request", "shipping_pct out of range");
        }
        cfg.shipping_pct = (float)num;
    }
    if (json_get_num(body, (size_t)len, "max_duration_minutes", &num)) {
        cfg.max_duration_minutes = (uint32_t)num;
    }
    if (json_get_bool(body, (size_t)len, "auto_recharge_to_shipping", &flag)) {
        cfg.auto_recharge_to_shipping = flag;
    }
    if (cfg.shipping_pct <= 0.0f) {
        cfg.shipping_pct = 60.0f;
    }

    const esp_err_t err = test_engine_configure((uint8_t)slot, &cfg);
    if (err == ESP_ERR_INVALID_STATE) {
        return send_error(req, "409 Conflict", "slot is running");
    }
    if (err != ESP_OK) {
        return send_error(req, "400 Bad Request", esp_err_to_name(err));
    }

    /* Echo the resolved profile so the client sees what it actually got. */
    test_engine_get_status((uint8_t)slot, &st);
    json_out_t j;
    json_init(&j, s_resp, sizeof(s_resp));
    emit_slot(&j, (uint8_t)slot, &st, false);
    return send_json(req, &j);
}

static esp_err_t h_slot_serial(httpd_req_t *req)
{
    const int slot = slot_from_uri(req->uri);
    if (slot < 0) {
        return send_error(req, "404 Not Found", "bad slot");
    }

    char body[REQ_BUF];
    const int len = read_body(req, body, sizeof(body));
    if (len <= 0) {
        return send_error(req, "400 Bad Request", "missing body");
    }

    char serial[SERIAL_MAX];
    if (!json_get_str(body, (size_t)len, "serial", serial, sizeof(serial))) {
        return send_error(req, "400 Bad Request", "missing serial");
    }
    if (test_engine_set_serial((uint8_t)slot, serial) != ESP_OK) {
        return send_error(req, "500 Internal Server Error", "set failed");
    }
    return send_ok(req);
}

static esp_err_t h_slot_action(httpd_req_t *req)
{
    const int slot = slot_from_uri(req->uri);
    if (slot < 0) {
        return send_error(req, "404 Not Found", "bad slot");
    }

    esp_err_t err;
    if (strstr(req->uri, "/start") != NULL) {
        err = test_engine_start((uint8_t)slot);
    } else if (strstr(req->uri, "/abort") != NULL) {
        err = test_engine_abort((uint8_t)slot);
    } else if (strstr(req->uri, "/clear") != NULL) {
        err = test_engine_clear_fault((uint8_t)slot);
    } else {
        return send_error(req, "404 Not Found", "unknown action");
    }

    if (err == ESP_ERR_INVALID_STATE) {
        return send_error(req, "409 Conflict",
                          "slot not startable - configure it, or clear its fault");
    }
    if (err != ESP_OK) {
        return send_error(req, "500 Internal Server Error", esp_err_to_name(err));
    }
    return send_ok(req);
}

static esp_err_t h_abort_all(httpd_req_t *req)
{
    test_engine_abort_all();
    return send_ok(req);
}

static esp_err_t h_results(httpd_req_t *req)
{
    const uint32_t offset = query_u32(req, "offset", 0);
    uint32_t limit = query_u32(req, "limit", RESULTS_PAGE);
    if (limit == 0 || limit > RESULTS_PAGE) {
        limit = RESULTS_PAGE;
    }

    const size_t total = result_store_history_count();

    json_out_t j;
    chunk_begin(req, &j);
    json_obj_open(&j, NULL);
    json_kv_u(&j, "total", (uint32_t)total);
    json_kv_u(&j, "offset", offset);
    json_arr_open(&j, "results");

    for (uint32_t i = 0; i < limit; i++) {
        slot_result_t r;
        if (result_store_history_at(offset + i, &r) != ESP_OK) {
            break;
        }
        json_sep(&j);
        /* emit_result opens its own object, so wrap it to keep the array
         * elements as plain objects. */
        json_obj_open(&j, NULL);
        json_kv_u(&j, "index", offset + i);
        emit_result(&j, "result", &r);
        json_obj_close(&j);
        if (chunk_flush(req, &j) != ESP_OK) {
            return httpd_resp_send_chunk(req, NULL, 0);
        }
    }

    json_arr_close(&j);
    json_obj_close(&j);
    return chunk_end(req, &j);
}

static esp_err_t h_catalog(httpd_req_t *req)
{
    json_out_t j;
    chunk_begin(req, &j);

    json_obj_open(&j, NULL);

    json_arr_open(&j, "chemistries");
    for (int i = 0; i < CELL_CHEM_COUNT; i++) {
        const cell_chemistry_profile_t *cp = cell_chemistry_get((cell_chemistry_t)i);
        if (cp == NULL) {
            continue;
        }
        json_obj_open(&j, NULL);
        json_kv_str(&j, "name", cp->name);
        json_kv_f(&j, "nominal_v", cp->nominal_v, 2);
        json_kv_f(&j, "charge_v_max", cp->charge_v_max, 3);
        json_kv_f(&j, "discharge_v_min", cp->discharge_v_min, 3);
        json_kv_f(&j, "storage_v", cp->storage_v, 3);
        json_kv_f(&j, "default_charge_c", cp->default_charge_c, 2);
        json_kv_f(&j, "default_discharge_c", cp->default_discharge_c, 2);
        json_kv_f(&j, "charge_term_c", cp->charge_term_c, 3);
        json_kv_f(&j, "temp_min_c", cp->temp_min_c, 1);
        json_kv_f(&j, "temp_max_c", cp->temp_max_c, 1);
        json_kv_f(&j, "rest_tolerance_pct", cp->rest_tolerance_pct, 1);
        json_kv_u(&j, "rest_minutes", cp->rest_minutes);
        json_obj_close(&j);
        if (chunk_flush(req, &j) != ESP_OK) {
            return httpd_resp_send_chunk(req, NULL, 0);
        }
    }
    json_arr_close(&j);

    json_arr_open(&j, "models");
    for (size_t i = 0; i < cell_model_count(); i++) {
        const cell_model_t *m = cell_model_at(i);
        if (m == NULL) {
            continue;
        }
        json_obj_open(&j, NULL);
        json_kv_str(&j, "name", m->name);
        json_kv_str(&j, "manufacturer", m->manufacturer);
        json_kv_str(&j, "chemistry", cell_chemistry_name(m->chemistry));
        json_kv_f(&j, "capacity_mah", m->capacity_mah, 0);
        json_kv_f(&j, "charge_current_max_a", m->charge_current_max_a, 2);
        json_kv_f(&j, "discharge_current_max_a", m->discharge_current_max_a, 2);
        json_obj_close(&j);
        if (chunk_flush(req, &j) != ESP_OK) {
            return httpd_resp_send_chunk(req, NULL, 0);
        }
    }
    json_arr_close(&j);

    json_obj_close(&j);
    return chunk_end(req, &j);
}

/*
 * Overrides a chemistry profile and persists it.
 *
 * Every field is optional; what is not supplied keeps its current value, so
 * a client can nudge one cutoff without restating the whole envelope.
 */
static esp_err_t h_chemistry_post(httpd_req_t *req)
{
    const char *name = strrchr(req->uri, '/');
    if (name == NULL || name[1] == '\0') {
        return send_error(req, "404 Not Found", "missing chemistry");
    }
    name++;

    cell_chemistry_t chem;
    if (!cell_chemistry_from_name(name, &chem)) {
        return send_error(req, "404 Not Found", "unknown chemistry");
    }

    const cell_chemistry_profile_t *current = cell_chemistry_get(chem);
    if (current == NULL) {
        return send_error(req, "500 Internal Server Error", "no profile");
    }
    cell_chemistry_profile_t p = *current;

    char body[REQ_BUF];
    const int len = read_body(req, body, sizeof(body));
    if (len <= 0) {
        return send_error(req, "400 Bad Request", "missing body");
    }

    double num;
    if (json_get_num(body, (size_t)len, "nominal_v", &num))           p.nominal_v = (float)num;
    if (json_get_num(body, (size_t)len, "charge_v_max", &num))        p.charge_v_max = (float)num;
    if (json_get_num(body, (size_t)len, "discharge_v_min", &num))     p.discharge_v_min = (float)num;
    if (json_get_num(body, (size_t)len, "storage_v", &num))           p.storage_v = (float)num;
    if (json_get_num(body, (size_t)len, "default_charge_c", &num))    p.default_charge_c = (float)num;
    if (json_get_num(body, (size_t)len, "default_discharge_c", &num)) p.default_discharge_c = (float)num;
    if (json_get_num(body, (size_t)len, "charge_term_c", &num))       p.charge_term_c = (float)num;
    if (json_get_num(body, (size_t)len, "temp_min_c", &num))          p.temp_min_c = (float)num;
    if (json_get_num(body, (size_t)len, "temp_max_c", &num))          p.temp_max_c = (float)num;
    if (json_get_num(body, (size_t)len, "rest_tolerance_pct", &num))  p.rest_tolerance_pct = (float)num;
    if (json_get_num(body, (size_t)len, "rest_minutes", &num))        p.rest_minutes = (uint32_t)num;

    /*
     * Sanity bounds before it goes to flash. cell_profile_resolve() clamps
     * to the unit envelope later, but a profile whose cutoff sits above its
     * charge ceiling would produce a test that terminates instantly, and
     * that is worth rejecting here rather than diagnosing at the bench.
     */
    if (p.charge_v_max <= p.discharge_v_min ||
        p.charge_v_max > BTS_UNIT_MAX_VOLTAGE_V ||
        p.discharge_v_min < 0.0f ||
        p.temp_max_c <= p.temp_min_c ||
        p.default_charge_c <= 0.0f || p.default_discharge_c <= 0.0f) {
        return send_error(req, "400 Bad Request", "profile fails sanity check");
    }

    const esp_err_t err = cell_chemistry_override_save(chem, &p);
    if (err != ESP_OK) {
        return send_error(req, "500 Internal Server Error", esp_err_to_name(err));
    }
    ESP_LOGI(TAG, "chemistry %s overridden", p.name);
    return send_ok(req);
}

static esp_err_t h_wifi_post(httpd_req_t *req)
{
    char body[REQ_BUF];
    const int len = read_body(req, body, sizeof(body));
    if (len <= 0) {
        return send_error(req, "400 Bad Request", "missing body");
    }

    char ssid[33];
    char pass[65] = {0};
    if (!json_get_str(body, (size_t)len, "ssid", ssid, sizeof(ssid))) {
        return send_error(req, "400 Bad Request", "missing ssid");
    }
    (void)json_get_str(body, (size_t)len, "password", pass, sizeof(pass));

    if (wifi_set_credentials(ssid, pass) != ESP_OK) {
        return send_error(req, "500 Internal Server Error", "save failed");
    }
    return send_ok(req);
}

/*
 * Raw register dump, for bring-up and for verifying the block strides
 * against a live unit. Not part of the control surface.
 */
static esp_err_t h_registers(httpd_req_t *req)
{
    const uint32_t addr  = query_u32(req, "addr", 0);
    uint32_t       count = query_u32(req, "count", 8);
    if (count == 0 || count > 32) {
        count = 32;
    }
    if (addr % BTS_REGISTER_SIZE != 0) {
        return send_error(req, "400 Bad Request", "addr must be a multiple of 4");
    }

    float values[32];
    const esp_err_t err = bts_link_read_block((uint16_t)addr, values, count);

    json_out_t j;
    json_init(&j, s_resp, sizeof(s_resp));
    json_obj_open(&j, NULL);
    json_kv_u(&j, "addr", addr);
    json_kv_u(&j, "count", count);
    json_kv_bool(&j, "ok", err == ESP_OK);
    if (err != ESP_OK) {
        json_kv_str(&j, "error", esp_err_to_name(err));
    } else {
        json_arr_open(&j, "values");
        for (uint32_t i = 0; i < count; i++) {
            json_sep(&j);
            json_kv_f(&j, NULL, values[i], 4);
        }
        json_arr_close(&j);
    }
    json_obj_close(&j);
    return send_json(req, &j);
}

/*
 * Bus-level I2C diagnostic, for bring-up.
 *
 * Distinguishes "a line is stuck low" (wiring, pull-ups) from "the bus is
 * idle but nothing answers" (address, power, SDA/SCL swapped) - both of
 * which surface as a bare ESP_ERR_TIMEOUT through /api/registers.
 */
static esp_err_t h_i2c_diag(httpd_req_t *req)
{
    bts_bus_diag_t diag;
    uint8_t found[16];
    const int n = bts_link_bus_diagnose(&diag, found, (int)(sizeof(found) / sizeof(found[0])));

    json_out_t j;
    json_init(&j, s_resp, sizeof(s_resp));
    json_obj_open(&j, NULL);
    json_kv_bool(&j, "sda_high", diag.sda_high);
    json_kv_bool(&j, "scl_high", diag.scl_high);
    json_kv_u(&j, "expected_addr", BTS_I2C_ADDRESS);
    json_kv_u(&j, "targets_found", (uint32_t)n);

    json_arr_open(&j, "addresses");
    const int shown = (n < (int)(sizeof(found) / sizeof(found[0])))
                          ? n : (int)(sizeof(found) / sizeof(found[0]));
    for (int i = 0; i < shown; i++) {
        json_sep(&j);
        json_kv_u(&j, NULL, found[i]);
    }
    json_arr_close(&j);

    const char *verdict;
    if (!diag.sda_high || !diag.scl_high) {
        verdict = "a bus line is stuck low - check pull-ups and wiring";
    } else if (n == 0) {
        verdict = "bus idle but no target answered - check address, power, "
                  "or whether SDA and SCL are swapped";
    } else {
        verdict = "bus healthy";
    }
    json_kv_str(&j, "verdict", verdict);
    json_obj_close(&j);
    return send_json(req, &j);
}

/* Preflight for the cross-origin POSTs above. */
static esp_err_t h_options(httpd_req_t *req)
{
    httpd_resp_set_hdr(req, "Access-Control-Allow-Origin", "*");
    httpd_resp_set_hdr(req, "Access-Control-Allow-Methods", "GET, POST, OPTIONS");
    httpd_resp_set_hdr(req, "Access-Control-Allow-Headers", "Content-Type");
    httpd_resp_set_status(req, "204 No Content");
    return httpd_resp_send(req, NULL, 0);
}

/* ------------------------------------------------------------------ */
/* Registration                                                       */
/* ------------------------------------------------------------------ */

/*
 * Slot routing.
 *
 * httpd_uri_match_wildcard() only honours a TRAILING asterisk. A pattern
 * with the wildcard in the middle, such as the slot number followed by an
 * action segment, never matches: the matcher compares the literal prefix up
 * to the asterisk and then accepts any tail. Registering the per-action
 * patterns individually therefore does not work - they all collapse onto
 * the "/api/slot/" prefix, and whichever was registered first wins every
 * request. That is what made a config POST return 405: the GET pattern
 * matched it first.
 *
 * So one pattern is registered per method and the trailing segment is
 * dispatched here. h_slot_get/h_slot_result already parse the slot number
 * out of the URI themselves, so this only has to pick the handler.
 */
static esp_err_t h_slot_get_dispatch(httpd_req_t *req)
{
    if (strstr(req->uri, "/result") != NULL) {
        return h_slot_result(req);
    }
    return h_slot_get(req);
}

static esp_err_t h_slot_post_dispatch(httpd_req_t *req)
{
    if (strstr(req->uri, "/config") != NULL) {
        return h_slot_config(req);
    }
    if (strstr(req->uri, "/serial") != NULL) {
        return h_slot_serial(req);
    }
    if (strstr(req->uri, "/start") != NULL ||
        strstr(req->uri, "/abort") != NULL ||
        strstr(req->uri, "/clear") != NULL) {
        return h_slot_action(req);
    }
    return send_error(req, "404 Not Found", "unknown slot action");
}

static const httpd_uri_t s_routes[] = {
    { .uri = "/api/status",          .method = HTTP_GET,  .handler = h_status       },
    { .uri = "/api/catalog",         .method = HTTP_GET,  .handler = h_catalog      },
    { .uri = "/api/results",         .method = HTTP_GET,  .handler = h_results      },
    { .uri = "/api/registers",       .method = HTTP_GET,  .handler = h_registers    },
    { .uri = "/api/i2c_diag",        .method = HTTP_GET,  .handler = h_i2c_diag     },
    { .uri = "/api/abort_all",       .method = HTTP_POST, .handler = h_abort_all    },
    { .uri = "/api/wifi",            .method = HTTP_POST, .handler = h_wifi_post    },
    { .uri = "/api/chemistry/*",     .method = HTTP_POST, .handler = h_chemistry_post },
    /*
     * One entry per method; the action is dispatched from the trailing
     * segment above. These must stay after the exact paths, because the
     * matcher takes the first registered pattern that matches.
     */
    { .uri = "/api/slot/*",          .method = HTTP_POST, .handler = h_slot_post_dispatch },
    { .uri = "/api/slot/*",          .method = HTTP_GET,  .handler = h_slot_get_dispatch  },
    { .uri = "/*",                   .method = HTTP_OPTIONS, .handler = h_options   },
};

esp_err_t web_api_init(const web_api_config_t *config)
{
    const web_api_config_t defaults = {
        .ap_ssid = "BTS-Tester",
        .ap_password = NULL,
        .port = 80,
    };
    if (config == NULL) {
        config = &defaults;
    }

    esp_err_t err = wifi_mgr_start(config->ap_ssid, config->ap_password);
    if (err != ESP_OK) {
        return err;
    }

    httpd_config_t cfg = HTTPD_DEFAULT_CONFIG();
    cfg.server_port      = config->port ? config->port : 80;
    cfg.max_uri_handlers = sizeof(s_routes) / sizeof(s_routes[0]) + 2;
    cfg.stack_size       = 8192;
    cfg.lru_purge_enable = true;
    /* Wildcards in the route table need the matcher that understands them. */
    cfg.uri_match_fn     = httpd_uri_match_wildcard;

    err = httpd_start(&s_server, &cfg);
    if (err != ESP_OK) {
        ESP_LOGE(TAG, "httpd_start: %s", esp_err_to_name(err));
        return err;
    }

    for (size_t i = 0; i < sizeof(s_routes) / sizeof(s_routes[0]); i++) {
        err = httpd_register_uri_handler(s_server, &s_routes[i]);
        if (err != ESP_OK) {
            ESP_LOGE(TAG, "route %s: %s", s_routes[i].uri, esp_err_to_name(err));
            return err;
        }
    }

    ESP_LOGI(TAG, "HTTP API on port %u", cfg.server_port);
    return ESP_OK;
}

bool web_api_sta_connected(void)
{
    return wifi_mgr_connected();
}
