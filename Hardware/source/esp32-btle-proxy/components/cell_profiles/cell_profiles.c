/*
 * cell_profiles.c
 *
 * Built-in chemistry and cell-model tables, plus resolution of a slot
 * configuration into concrete BTS limits.
 *
 * DATASHEET VALUES
 * ----------------
 * The model table carries manufacturer continuous ratings. Two of them are
 * deliberately NOT the datasheet maximum:
 *
 *   VTC5A and VTC6 are rated 30 A and 20 A continuous respectively, and the
 *   20Q/25R/30R family runs to 15-20 A. The TIDA-010086 channel tops out at
 *   10 A (BTS_CMPSS_FULLSCALE_A in bts_user_settings.h), so every entry is
 *   capped at the unit envelope by cell_profile_to_bts_limits() anyway. The
 *   table keeps the true datasheet figure so that the cap is visible and
 *   auditable rather than silently baked in.
 *
 * Charge ratings are the standard-charge figures, not the fast-charge ones:
 * a capacity test wants a repeatable charge, not the quickest one.
 */

#include <string.h>
#include <stdio.h>
#include "esp_log.h"
#include "nvs_flash.h"
#include "nvs.h"
#include "cell_profiles.h"

static const char *TAG = "cell_prof";
static const char *NVS_NAMESPACE = "cellchem";

/* ------------------------------------------------------------------ */
/* Built-in chemistry table                                           */
/* ------------------------------------------------------------------ */

/*
 * storage_v is the resting voltage at roughly 60% state of charge, which is
 * the shipping state the "recharge to shipping capacity" step targets. It is
 * only used as a sanity bound - the actual target is a coulomb count, not a
 * voltage, because resting voltage is a poor SoC proxy for LFP in
 * particular (its plateau is famously flat).
 */
static const cell_chemistry_profile_t k_chemistry[CELL_CHEM_COUNT] = {
    [CELL_CHEM_LCO] = {
        .name = "LCO",
        .nominal_v = 3.70f,
        .charge_v_max = 4.20f,
        .discharge_v_min = 3.00f,
        .storage_v = 3.80f,
        .default_charge_c = 0.5f,
        .default_discharge_c = 0.5f,
        .charge_term_c = 0.05f,
        .temp_min_c = 0.0f,
        .temp_max_c = 45.0f,
        .rest_tolerance_pct = 5.0f,
        .rest_minutes = 30,
    },
    [CELL_CHEM_LTO] = {
        /*
         * LTO is the outlier: 2.4 V nominal, and it tolerates very high
         * rates and sub-zero charging. The 1.5 V floor is the real cutoff,
         * well below the 2.5 V that a NMC-shaped assumption would apply.
         */
        .name = "LTO",
        .nominal_v = 2.40f,
        .charge_v_max = 2.80f,
        .discharge_v_min = 1.50f,
        .storage_v = 2.30f,
        .default_charge_c = 1.0f,
        .default_discharge_c = 1.0f,
        .charge_term_c = 0.05f,
        .temp_min_c = -20.0f,
        .temp_max_c = 55.0f,
        .rest_tolerance_pct = 5.0f,
        .rest_minutes = 15,
    },
    [CELL_CHEM_LFP] = {
        .name = "LFP",
        .nominal_v = 3.20f,
        .charge_v_max = 3.65f,
        .discharge_v_min = 2.50f,
        .storage_v = 3.30f,
        .default_charge_c = 0.5f,
        .default_discharge_c = 0.5f,
        .charge_term_c = 0.05f,
        .temp_min_c = 0.0f,
        .temp_max_c = 55.0f,
        .rest_tolerance_pct = 5.0f,
        .rest_minutes = 30,
    },
    [CELL_CHEM_NMC] = {
        .name = "NMC",
        .nominal_v = 3.60f,
        .charge_v_max = 4.20f,
        .discharge_v_min = 2.50f,
        .storage_v = 3.75f,
        .default_charge_c = 0.5f,
        .default_discharge_c = 1.0f,
        .charge_term_c = 0.05f,
        .temp_min_c = 0.0f,
        .temp_max_c = 60.0f,
        .rest_tolerance_pct = 5.0f,
        .rest_minutes = 30,
    },
    [CELL_CHEM_NONE] = {
        /*
         * The unit envelope and nothing narrower: 0 V to 5 V, so a 0 V
         * cutoff is allowed. The 1C rates against the 1000 mAh nominal
         * capacity below give 1 A defaults, and every current is meant to be
         * set directly. The temperature window is the sensor's, not a cell's.
         */
        .name = "NONE",
        .nominal_v = 0.0f,
        .charge_v_max = BTS_UNIT_MAX_VOLTAGE_V,
        .discharge_v_min = 0.0f,
        .storage_v = 0.0f,
        .default_charge_c = 1.0f,
        .default_discharge_c = 1.0f,
        .charge_term_c = 0.05f,
        .temp_min_c = -20.0f,
        .temp_max_c = 60.0f,
        .rest_tolerance_pct = 5.0f,
        .rest_minutes = 0,
    },
    [CELL_CHEM_NCA] = {
        .name = "NCA",
        .nominal_v = 3.60f,
        .charge_v_max = 4.20f,
        .discharge_v_min = 2.50f,
        .storage_v = 3.75f,
        .default_charge_c = 0.5f,
        .default_discharge_c = 1.0f,
        .charge_term_c = 0.05f,
        .temp_min_c = 0.0f,
        .temp_max_c = 60.0f,
        .rest_tolerance_pct = 5.0f,
        .rest_minutes = 30,
    },
};

/* Runtime copy, so NVS overrides can shadow the flash defaults. */
static cell_chemistry_profile_t s_chemistry[CELL_CHEM_COUNT];

/* ------------------------------------------------------------------ */
/* Built-in model table                                               */
/* ------------------------------------------------------------------ */

static const cell_model_t k_models[] = {
    /* Samsung INR18650 family. */
    { .name = "20Q",   .manufacturer = "Samsung", .chemistry = CELL_CHEM_NMC,
      .capacity_mah = 2000.0f, .charge_current_max_a = 2.0f,  .discharge_current_max_a = 15.0f },
    { .name = "25R",   .manufacturer = "Samsung", .chemistry = CELL_CHEM_NMC,
      .capacity_mah = 2500.0f, .charge_current_max_a = 4.0f,  .discharge_current_max_a = 20.0f },
    { .name = "30Q",   .manufacturer = "Samsung", .chemistry = CELL_CHEM_NMC,
      .capacity_mah = 3000.0f, .charge_current_max_a = 4.0f,  .discharge_current_max_a = 15.0f },
    { .name = "30R",   .manufacturer = "Samsung", .chemistry = CELL_CHEM_NMC,
      .capacity_mah = 3000.0f, .charge_current_max_a = 4.0f,  .discharge_current_max_a = 15.0f },

    /*
     * Sony/Murata VTC family. VTC3 and VTC4 are the older 1600/2100 mAh
     * high-drain cells; VTC5/5A/6 are the current generation.
     */
    { .name = "VTC3",  .manufacturer = "Sony",    .chemistry = CELL_CHEM_NMC,
      .capacity_mah = 1600.0f, .charge_current_max_a = 3.0f,  .discharge_current_max_a = 30.0f },
    { .name = "VTC4",  .manufacturer = "Sony",    .chemistry = CELL_CHEM_NMC,
      .capacity_mah = 2100.0f, .charge_current_max_a = 4.0f,  .discharge_current_max_a = 30.0f },
    { .name = "VTC5",  .manufacturer = "Sony",    .chemistry = CELL_CHEM_NMC,
      .capacity_mah = 2600.0f, .charge_current_max_a = 4.0f,  .discharge_current_max_a = 20.0f },
    { .name = "VTC5A", .manufacturer = "Sony",    .chemistry = CELL_CHEM_NMC,
      .capacity_mah = 2600.0f, .charge_current_max_a = 6.0f,  .discharge_current_max_a = 30.0f },
    { .name = "VTC6",  .manufacturer = "Sony",    .chemistry = CELL_CHEM_NMC,
      .capacity_mah = 3000.0f, .charge_current_max_a = 6.0f,  .discharge_current_max_a = 20.0f },
};

#define K_MODEL_COUNT (sizeof(k_models) / sizeof(k_models[0]))

/*
 * Custom models, in RAM and mirrored to NVS one blob per used entry
 * ("model<N>"). Kept packed: entries [0, s_custom_count) are valid, so
 * cell_model_at() can index straight through built-ins then customs.
 */
static cell_model_t s_custom[CELL_CUSTOM_MAX];
static size_t       s_custom_count;

/* ------------------------------------------------------------------ */
/* Helpers                                                            */
/* ------------------------------------------------------------------ */

static float clampf(float v, float lo, float hi)
{
    if (v < lo) return lo;
    if (v > hi) return hi;
    return v;
}

const char *cell_chemistry_name(cell_chemistry_t chem)
{
    if (chem >= CELL_CHEM_COUNT) {
        return "?";
    }
    return s_chemistry[chem].name;
}

bool cell_chemistry_from_name(const char *name, cell_chemistry_t *out)
{
    if (name == NULL || out == NULL) {
        return false;
    }
    for (int i = 0; i < CELL_CHEM_COUNT; i++) {
        if (strcasecmp(name, s_chemistry[i].name) == 0) {
            *out = (cell_chemistry_t)i;
            return true;
        }
    }
    return false;
}

const cell_chemistry_profile_t *cell_chemistry_get(cell_chemistry_t chem)
{
    if (chem >= CELL_CHEM_COUNT) {
        return NULL;
    }
    return &s_chemistry[chem];
}

size_t cell_model_count(void)
{
    return K_MODEL_COUNT + s_custom_count;
}

size_t cell_model_builtin_count(void)
{
    return K_MODEL_COUNT;
}

const cell_model_t *cell_model_at(size_t index)
{
    if (index < K_MODEL_COUNT) {
        return &k_models[index];
    }
    index -= K_MODEL_COUNT;
    if (index < s_custom_count) {
        return &s_custom[index];
    }
    return NULL;
}

bool cell_model_is_custom(const cell_model_t *model)
{
    return model >= &s_custom[0] && model < &s_custom[CELL_CUSTOM_MAX];
}

static const cell_model_t *builtin_find(const char *name)
{
    for (size_t i = 0; i < K_MODEL_COUNT; i++) {
        if (strcasecmp(name, k_models[i].name) == 0) {
            return &k_models[i];
        }
    }
    return NULL;
}

static int custom_index(const char *name)
{
    for (size_t i = 0; i < s_custom_count; i++) {
        if (strcasecmp(name, s_custom[i].name) == 0) {
            return (int)i;
        }
    }
    return -1;
}

const cell_model_t *cell_model_find(const char *name)
{
    if (name == NULL || name[0] == '\0') {
        return NULL;
    }
    const cell_model_t *m = builtin_find(name);
    if (m != NULL) {
        return m;
    }
    const int i = custom_index(name);
    return (i >= 0) ? &s_custom[i] : NULL;
}

/* ------------------------------------------------------------------ */
/* Resolution                                                         */
/* ------------------------------------------------------------------ */

esp_err_t cell_profile_resolve(cell_chemistry_t chem,
                               const char *model_name,
                               float capacity_mah_override,
                               float charge_c,
                               float discharge_c,
                               cell_resolved_profile_t *out)
{
    if (out == NULL) {
        return ESP_ERR_INVALID_ARG;
    }

    const cell_model_t *model = cell_model_find(model_name);
    if (model != NULL) {
        chem = model->chemistry;
    }
    if (chem >= CELL_CHEM_COUNT) {
        return ESP_ERR_INVALID_ARG;
    }

    const cell_chemistry_profile_t *cp = &s_chemistry[chem];

    memset(out, 0, sizeof(*out));
    out->chemistry = chem;
    out->charge_v_max       = cp->charge_v_max;
    out->discharge_v_min    = cp->discharge_v_min;
    out->storage_v          = cp->storage_v;
    out->temp_min_c         = cp->temp_min_c;
    out->temp_max_c         = cp->temp_max_c;
    out->rest_tolerance_pct = cp->rest_tolerance_pct;
    out->rest_minutes       = cp->rest_minutes;

    if (model != NULL) {
        snprintf(out->model_name, sizeof(out->model_name), "%s", model->name);
        out->capacity_mah = model->capacity_mah;
        /* Datasheet voltages override chemistry defaults when specified. */
        if (model->charge_v_max > 0.0f) {
            out->charge_v_max = model->charge_v_max;
        }
        if (model->discharge_v_min > 0.0f) {
            out->discharge_v_min = model->discharge_v_min;
        }
    }

    /* A user-entered capacity always wins: aged cells are the normal case. */
    if (capacity_mah_override > 0.0f) {
        out->capacity_mah = capacity_mah_override;
    }
    /*
     * NONE has no cell to take a capacity from. 1000 mAh is a nominal figure
     * that makes the 1C defaults 1 A; it only sets defaults and the progress
     * figure, never a limit.
     */
    if (chem == CELL_CHEM_NONE && out->capacity_mah <= 0.0f) {
        out->capacity_mah = 1000.0f;
    }
    if (out->capacity_mah <= 0.0f) {
        ESP_LOGE(TAG, "no capacity for chem=%s model=%s",
                 cp->name, model_name ? model_name : "(none)");
        return ESP_ERR_INVALID_ARG;
    }

    float c_chg = (charge_c    > 0.0f) ? charge_c    : cp->default_charge_c;
    float c_dis = (discharge_c > 0.0f) ? discharge_c : cp->default_discharge_c;

    /* C rate -> amps. capacity is mAh, so /1000 to get Ah. */
    const float capacity_ah = out->capacity_mah / 1000.0f;
    out->charge_current_a      = capacity_ah * c_chg;
    out->discharge_current_a   = capacity_ah * c_dis;
    out->charge_term_current_a = capacity_ah * cp->charge_term_c;

    /* Respect the cell's own continuous rating before the unit envelope. */
    if (model != NULL) {
        if (model->charge_current_max_a > 0.0f &&
            out->charge_current_a > model->charge_current_max_a) {
            out->charge_current_a = model->charge_current_max_a;
        }
        if (model->discharge_current_max_a > 0.0f &&
            out->discharge_current_a > model->discharge_current_max_a) {
            out->discharge_current_a = model->discharge_current_max_a;
        }
    }

    /* Then the unit envelope. */
    out->charge_current_a    = clampf(out->charge_current_a,    0.0f, BTS_UNIT_MAX_CURRENT_A);
    out->discharge_current_a = clampf(out->discharge_current_a, 0.0f, BTS_UNIT_MAX_CURRENT_A);
    out->charge_v_max        = clampf(out->charge_v_max,        0.0f, BTS_UNIT_MAX_VOLTAGE_V);
    out->discharge_v_min     = clampf(out->discharge_v_min,     0.0f, BTS_UNIT_MAX_VOLTAGE_V);

    return ESP_OK;
}

void cell_profile_to_bts_limits(const cell_resolved_profile_t *p,
                                bts_channel_limits_t *out)
{
    if (p == NULL || out == NULL) {
        return;
    }
    memset(out, 0, sizeof(*out));

    /*
     * modeCallback() on CPU1 latches vref from the MAX register and the
     * cutout from the MIN register of whichever direction is starting:
     *
     *   charge:     vref_charge_V    = ChargeVoltageMax
     *               iref_A           = ChargeCurrentMax
     *               iref_cuttout_A   = ChargeCurrentMin
     *   discharge:  vref_discharge_V = DischargeVoltageMin
     *               iref_A           = DischargeCurrentMax
     *               iref_cuttout_A   = DischargeCurrentMin
     *
     * So DischargeVoltageMin carries the end-of-discharge cutoff and
     * ChargeVoltageMax carries the CV target. The two remaining registers
     * are bounds rather than setpoints.
     */
    out->charge_voltage_max    = p->charge_v_max;
    out->charge_voltage_min    = p->discharge_v_min;
    out->discharge_voltage_min = p->discharge_v_min;
    out->discharge_voltage_max = p->charge_v_max;

    out->charge_current_max    = p->charge_current_a;
    out->charge_current_min    = p->charge_term_current_a;
    out->discharge_current_max = p->discharge_current_a;
    /*
     * Discharge is terminated by the engine on the voltage cutoff, not by a
     * current taper, so the minimum is left at zero rather than at the
     * charge taper value.
     */
    out->discharge_current_min = 0.0f;

    out->min_cell_temp = p->temp_min_c;
    out->max_cell_temp = p->temp_max_c;
}

/* ------------------------------------------------------------------ */
/* NVS overrides                                                      */
/* ------------------------------------------------------------------ */

static void chem_nvs_key(cell_chemistry_t chem, char *buf, size_t len)
{
    snprintf(buf, len, "chem%d", (int)chem);
}

static void model_nvs_key(int index, char *buf, size_t len)
{
    snprintf(buf, len, "model%d", index);
}

/*
 * A custom model must be usable as-is: a short printable name, a chemistry
 * that exists, a capacity, and figures inside the unit's envelope. Checked on
 * save and again on load, so nothing out of range ever reaches resolution.
 */
static esp_err_t model_validate(const cell_model_t *m)
{
    const size_t n = strnlen(m->name, CELL_NAME_MAX);
    if (n == 0 || n >= CELL_CUSTOM_NAME_MAX) {
        return ESP_ERR_INVALID_ARG;
    }
    for (size_t i = 0; i < n; i++) {
        const char c = m->name[i];
        const bool ok = (c >= '0' && c <= '9') || (c >= 'A' && c <= 'Z') ||
                        (c >= 'a' && c <= 'z') || c == '-' || c == '_';
        if (!ok) {
            return ESP_ERR_INVALID_ARG;
        }
    }
    if (m->chemistry >= CELL_CHEM_COUNT) {
        return ESP_ERR_INVALID_ARG;
    }
    if (!(m->capacity_mah > 0.0f) || m->capacity_mah > 100000.0f) {
        return ESP_ERR_INVALID_ARG;
    }
    if (m->charge_current_max_a < 0.0f || m->discharge_current_max_a < 0.0f ||
        m->charge_current_max_a > 1000.0f || m->discharge_current_max_a > 1000.0f) {
        return ESP_ERR_INVALID_ARG;
    }
    if (m->charge_v_max < 0.0f || m->charge_v_max > BTS_UNIT_MAX_VOLTAGE_V ||
        m->discharge_v_min < 0.0f || m->discharge_v_min > BTS_UNIT_MAX_VOLTAGE_V) {
        return ESP_ERR_INVALID_ARG;
    }
    if (m->charge_v_max > 0.0f && m->discharge_v_min >= m->charge_v_max) {
        return ESP_ERR_INVALID_ARG;
    }
    return ESP_OK;
}

/*
 * Rewrites every custom-model key from RAM, so NVS always holds exactly
 * [0, s_custom_count) packed - a delete from the middle cannot leave a hole
 * that a later load would read as a gap.
 */
static esp_err_t custom_store_all(void)
{
    nvs_handle_t h;
    esp_err_t err = nvs_open(NVS_NAMESPACE, NVS_READWRITE, &h);
    if (err != ESP_OK) {
        return err;
    }
    for (int i = 0; i < CELL_CUSTOM_MAX && err == ESP_OK; i++) {
        char key[16];
        model_nvs_key(i, key, sizeof(key));
        if ((size_t)i < s_custom_count) {
            err = nvs_set_blob(h, key, &s_custom[i], sizeof(s_custom[i]));
        } else {
            const esp_err_t e = nvs_erase_key(h, key);
            err = (e == ESP_ERR_NVS_NOT_FOUND) ? ESP_OK : e;
        }
    }
    if (err == ESP_OK) {
        err = nvs_commit(h);
    }
    nvs_close(h);
    return err;
}

esp_err_t cell_model_custom_save(const cell_model_t *model)
{
    if (model == NULL) {
        return ESP_ERR_INVALID_ARG;
    }
    cell_model_t m;
    memset(&m, 0, sizeof(m));
    snprintf(m.name, sizeof(m.name), "%s", model->name);
    snprintf(m.manufacturer, sizeof(m.manufacturer), "%s", model->manufacturer);
    m.chemistry               = model->chemistry;
    m.capacity_mah            = model->capacity_mah;
    m.charge_current_max_a    = model->charge_current_max_a;
    m.discharge_current_max_a = model->discharge_current_max_a;
    m.charge_v_max            = model->charge_v_max;
    m.discharge_v_min         = model->discharge_v_min;

    esp_err_t err = model_validate(&m);
    if (err != ESP_OK) {
        return err;
    }
    if (builtin_find(m.name) != NULL) {
        return ESP_ERR_NOT_ALLOWED;
    }

    const cell_model_t *old = NULL;
    const int at = custom_index(m.name);
    cell_model_t prev;
    if (at >= 0) {
        prev = s_custom[at];
        old  = &prev;
        s_custom[at] = m;
    } else {
        if (s_custom_count >= CELL_CUSTOM_MAX) {
            return ESP_ERR_NO_MEM;
        }
        s_custom[s_custom_count++] = m;
    }

    err = custom_store_all();
    if (err != ESP_OK) {
        /* Put RAM back the way NVS still has it. */
        if (old != NULL) {
            s_custom[at] = prev;
        } else {
            s_custom_count--;
        }
        return err;
    }
    ESP_LOGI(TAG, "custom model %s saved (%u of %d)", m.name,
             (unsigned)s_custom_count, CELL_CUSTOM_MAX);
    return ESP_OK;
}

esp_err_t cell_model_custom_delete(const char *name)
{
    if (name == NULL) {
        return ESP_ERR_INVALID_ARG;
    }
    const int at = custom_index(name);
    if (at < 0) {
        return ESP_ERR_NOT_FOUND;
    }
    const cell_model_t removed = s_custom[at];
    for (size_t i = (size_t)at; i + 1 < s_custom_count; i++) {
        s_custom[i] = s_custom[i + 1];
    }
    s_custom_count--;

    const esp_err_t err = custom_store_all();
    if (err != ESP_OK) {
        for (size_t i = s_custom_count; i > (size_t)at; i--) {
            s_custom[i] = s_custom[i - 1];
        }
        s_custom[at] = removed;
        s_custom_count++;
        return err;
    }
    ESP_LOGI(TAG, "custom model %s deleted", removed.name);
    return ESP_OK;
}

esp_err_t cell_chemistry_override_save(cell_chemistry_t chem,
                                       const cell_chemistry_profile_t *profile)
{
    if (chem >= CELL_CHEM_COUNT || profile == NULL) {
        return ESP_ERR_INVALID_ARG;
    }

    nvs_handle_t h;
    esp_err_t err = nvs_open(NVS_NAMESPACE, NVS_READWRITE, &h);
    if (err != ESP_OK) {
        return err;
    }

    char key[16];
    chem_nvs_key(chem, key, sizeof(key));
    err = nvs_set_blob(h, key, profile, sizeof(*profile));
    if (err == ESP_OK) {
        err = nvs_commit(h);
    }
    nvs_close(h);

    if (err == ESP_OK) {
        memcpy(&s_chemistry[chem], profile, sizeof(*profile));
        ESP_LOGI(TAG, "chemistry %s overridden", profile->name);
    }
    return err;
}

esp_err_t cell_chemistry_override_clear(cell_chemistry_t chem)
{
    if (chem >= CELL_CHEM_COUNT) {
        return ESP_ERR_INVALID_ARG;
    }

    nvs_handle_t h;
    esp_err_t err = nvs_open(NVS_NAMESPACE, NVS_READWRITE, &h);
    if (err != ESP_OK) {
        return err;
    }

    char key[16];
    chem_nvs_key(chem, key, sizeof(key));
    err = nvs_erase_key(h, key);
    if (err == ESP_OK || err == ESP_ERR_NVS_NOT_FOUND) {
        nvs_commit(h);
        err = ESP_OK;
    }
    nvs_close(h);

    memcpy(&s_chemistry[chem], &k_chemistry[chem], sizeof(k_chemistry[chem]));
    return err;
}

esp_err_t cell_profiles_init(void)
{
    memcpy(s_chemistry, k_chemistry, sizeof(s_chemistry));
    s_custom_count = 0;

    nvs_handle_t h;
    if (nvs_open(NVS_NAMESPACE, NVS_READONLY, &h) != ESP_OK) {
        ESP_LOGI(TAG, "no chemistry overrides, using built-in defaults");
        return ESP_OK;
    }

    for (int i = 0; i < CELL_CHEM_COUNT; i++) {
        char key[16];
        chem_nvs_key((cell_chemistry_t)i, key, sizeof(key));

        cell_chemistry_profile_t stored;
        size_t len = sizeof(stored);
        if (nvs_get_blob(h, key, &stored, &len) == ESP_OK && len == sizeof(stored)) {
            memcpy(&s_chemistry[i], &stored, sizeof(stored));
            ESP_LOGI(TAG, "loaded override for %s", stored.name);
        }
    }

    /*
     * Custom models. Any blob that fails validation now - a size change
     * across firmware versions, a name a later build made a built-in - is
     * skipped rather than loaded, so a bad record can never shadow the
     * reference table.
     */
    for (int i = 0; i < CELL_CUSTOM_MAX; i++) {
        char key[16];
        model_nvs_key(i, key, sizeof(key));

        cell_model_t stored;
        size_t len = sizeof(stored);
        if (nvs_get_blob(h, key, &stored, &len) != ESP_OK || len != sizeof(stored)) {
            continue;
        }
        stored.name[CELL_CUSTOM_NAME_MAX - 1] = '\0';
        stored.manufacturer[CELL_NAME_MAX - 1] = '\0';
        if (model_validate(&stored) != ESP_OK || custom_index(stored.name) >= 0) {
            ESP_LOGW(TAG, "skipping invalid custom model in %s", key);
            continue;
        }
        s_custom[s_custom_count++] = stored;
        ESP_LOGI(TAG, "loaded custom model %s", stored.name);
    }
    nvs_close(h);
    return ESP_OK;
}
