/*
 * json_min.h
 *
 * Minimal JSON emit/parse helpers.
 *
 * WHY NOT cJSON
 * -------------
 * ESP-IDF 6.1 no longer bundles cJSON; it is a registry component
 * (espressif/cjson) fetched at configure time. This project has to build on
 * a bench machine that may be offline, and the JSON it handles is entirely
 * fixed-shape: the responses are built field by field, and the request
 * bodies are flat objects of string, number and boolean values with no
 * nesting or arrays. A dependency resolver is not worth that.
 *
 * The emitter is a bounded appender that tracks overflow and never writes
 * past the buffer. The parser is a scanner over the raw body: it finds a
 * top-level key and reads its value. It does NOT validate the document, so
 * it is only safe against input the caller is willing to treat as
 * best-effort - which is what an "all fields optional" config POST is.
 */

#ifndef JSON_MIN_H
#define JSON_MIN_H

#include <stdint.h>
#include <stdbool.h>
#include <stddef.h>

#ifdef __cplusplus
extern "C" {
#endif

/* ---- emit ---- */

typedef struct {
    char  *buf;
    size_t cap;
    size_t len;
    bool   overflow;
    /*
     * Last character emitted, retained across a json_drain(). json_sep()
     * decides whether a comma is needed from this rather than from the
     * buffer contents, so a document can be flushed mid-way and continued.
     */
    char   last;
} json_out_t;

void json_init(json_out_t *j, char *buf, size_t cap);

/*
 * Empties the buffer without ending the document: the caller has just sent
 * what was in it. Separator state is preserved, so emitting continues as if
 * nothing had been flushed.
 */
void json_drain(json_out_t *j);

void json_raw(json_out_t *j, const char *text);
void json_obj_open(json_out_t *j, const char *key);   /* key may be NULL */
void json_obj_close(json_out_t *j);
void json_arr_open(json_out_t *j, const char *key);
void json_arr_close(json_out_t *j);
void json_kv_str(json_out_t *j, const char *key, const char *value);
void json_kv_f(json_out_t *j, const char *key, float value, int decimals);
void json_kv_i(json_out_t *j, const char *key, int64_t value);
void json_kv_u(json_out_t *j, const char *key, uint32_t value);
void json_kv_bool(json_out_t *j, const char *key, bool value);
/* Separator between sibling values; emits ',' only when one is needed. */
void json_sep(json_out_t *j);

static inline bool json_ok(const json_out_t *j) { return !j->overflow; }

/* ---- parse ---- */

/*
 * All three return false when the key is absent or the value does not parse.
 * `body` need not be NUL-terminated beyond `len`.
 */
bool json_get_str(const char *body, size_t len, const char *key,
                  char *out, size_t out_len);
bool json_get_num(const char *body, size_t len, const char *key, double *out);
bool json_get_bool(const char *body, size_t len, const char *key, bool *out);

#ifdef __cplusplus
}
#endif

#endif /* JSON_MIN_H */
