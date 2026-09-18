idf_component_register(
    SRCS "test_engine.c" "coulomb_counter.c" "result_store.c"
    INCLUDE_DIRS "include"
    REQUIRES bts_link cell_profiles nvs_flash esp_timer
)
