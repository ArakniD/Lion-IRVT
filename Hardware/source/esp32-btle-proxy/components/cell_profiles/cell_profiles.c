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
    return K_MODEL_COUNT;
}

const cell_model_t *cell_model_at(size_t index)
{
    if (index >= K_MODEL_COUNT) {
        return NULL;
    }
    return &k_models[index];
}

const cell_model_t *cell_model_find(const char *name)
{
    if (name == NULL || name[0] == '\0') {
        return NULL;
    }
    for (size_t i = 0; i < K_MODEL_COUNT; i++) {
        if (strcasecmp(name, k_models[i].name) == 0) {
            return &k_models[i];
        }
    }
    return NULL;
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
    nvs_close(h);
    return ESP_OK;
}
