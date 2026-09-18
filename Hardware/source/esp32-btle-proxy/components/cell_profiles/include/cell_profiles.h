/*
 * cell_profiles.h
 *
 * Battery chemistry and cell-model definitions.
 *
 * A slot's electrical envelope is built in two layers:
 *
 *   chemistry  voltage envelope and default C rates, one per chemistry
 *   model      a specific commercial cell, which pins capacity and the
 *              manufacturer's own current ratings
 *
 * Selecting a model implies its chemistry and overrides the chemistry
 * defaults where the datasheet is more specific. Selecting a bare chemistry
 * with a user-entered capacity is also supported, for cells with no entry in
 * the model table.
 *
 * Built-in definitions live in flash. User overrides are persisted to NVS
 * and shadow the built-ins by name.
 */

#ifndef CELL_PROFILES_H
#define CELL_PROFILES_H

#include <stdint.h>
#include <stdbool.h>
#include "esp_err.h"
#include "bts_link.h"

#ifdef __cplusplus
extern "C" {
#endif

#define CELL_NAME_MAX       24
#define CELL_MAX_MODELS     32
#define CELL_MAX_CHEMISTRY  8

typedef enum {
    CELL_CHEM_LCO = 0,   /* LiCoO2            */
    CELL_CHEM_LTO,       /* Li4Ti5O12         */
    CELL_CHEM_LFP,       /* LiFePO4           */
    CELL_CHEM_NMC,       /* LiNiMnCoO2        */
    CELL_CHEM_NCA,       /* LiNiCoAlO2        */
    CELL_CHEM_COUNT,
} cell_chemistry_t;

/*
 * Per-chemistry electrical envelope.
 *
 * All voltages are per cell. The rest_tolerance_pct field drives the
 * "is this cell close enough to full to discharge immediately" decision in
 * the test engine.
 */
typedef struct {
    char  name[CELL_NAME_MAX];
    float nominal_v;
    float charge_v_max;         /* CV target / absolute ceiling      */
    float discharge_v_min;      /* cutoff, the cell is empty here    */
    float storage_v;            /* ~60% SoC resting voltage          */
    float default_charge_c;     /* C rate for charge                 */
    float default_discharge_c;  /* C rate for capacity discharge     */
    float charge_term_c;        /* CV taper cutoff, as a C rate      */
    float temp_min_c;
    float temp_max_c;
    /*
     * How close to charge_v_max a rested cell must sit before the engine is
     * willing to skip the top-up charge and discharge immediately. Expressed
     * as a percentage of charge_v_max.
     */
    float rest_tolerance_pct;
    uint32_t rest_minutes;      /* settle time after a charge        */
} cell_chemistry_profile_t;

/*
 * A specific commercial cell.
 *
 * current_max_a fields are the manufacturer's continuous ratings, not the
 * unit's capability - the engine takes the lower of the two.
 */
typedef struct {
    char             name[CELL_NAME_MAX];
    char             manufacturer[CELL_NAME_MAX];
    cell_chemistry_t chemistry;
    float            capacity_mah;
    float            charge_current_max_a;
    float            discharge_current_max_a;
    float            charge_v_max;        /* 0 => inherit chemistry */
    float            discharge_v_min;     /* 0 => inherit chemistry */
} cell_model_t;

/*
 * Fully resolved parameters for one slot, after chemistry defaults, model
 * overrides, user capacity and the unit envelope have all been applied.
 */
typedef struct {
    cell_chemistry_t chemistry;
    char             model_name[CELL_NAME_MAX];
    float            capacity_mah;
    float            charge_v_max;
    float            discharge_v_min;
    float            storage_v;
    float            charge_current_a;      /* derived from C rate    */
    float            discharge_current_a;   /* derived from C rate    */
    float            charge_term_current_a;
    float            temp_min_c;
    float            temp_max_c;
    float            rest_tolerance_pct;
    uint32_t         rest_minutes;
} cell_resolved_profile_t;

esp_err_t cell_profiles_init(void);

const cell_chemistry_profile_t *cell_chemistry_get(cell_chemistry_t chem);
const char *cell_chemistry_name(cell_chemistry_t chem);
bool cell_chemistry_from_name(const char *name, cell_chemistry_t *out);

size_t cell_model_count(void);
const cell_model_t *cell_model_at(size_t index);
const cell_model_t *cell_model_find(const char *name);

/*
 * Resolves a slot configuration into a concrete parameter set.
 *
 * `model_name` may be NULL or empty, in which case `chem` and
 * `capacity_mah_override` are used directly. A non-zero
 * `capacity_mah_override` always wins over the model's datasheet capacity,
 * so a partially-aged cell can be tested against its real capacity.
 *
 * charge_c / discharge_c of 0 mean "use the chemistry default".
 */
esp_err_t cell_profile_resolve(cell_chemistry_t chem,
                               const char *model_name,
                               float capacity_mah_override,
                               float charge_c,
                               float discharge_c,
                               cell_resolved_profile_t *out);

/*
 * Converts a resolved profile into the BTS control-block limits.
 *
 * This is where the unit envelope is enforced: 0-5 V and +/-10 A per
 * channel, from BTS_UNIT_MAX_VOLTAGE_V / BTS_UNIT_MAX_CURRENT_A.
 */
void cell_profile_to_bts_limits(const cell_resolved_profile_t *profile,
                                bts_channel_limits_t *out);

/* Persist / load a user override of a chemistry profile. */
esp_err_t cell_chemistry_override_save(cell_chemistry_t chem,
                                       const cell_chemistry_profile_t *profile);
esp_err_t cell_chemistry_override_clear(cell_chemistry_t chem);

#ifdef __cplusplus
}
#endif

#endif /* CELL_PROFILES_H */
