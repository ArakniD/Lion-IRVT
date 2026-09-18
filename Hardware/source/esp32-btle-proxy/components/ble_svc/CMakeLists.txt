idf_component_register(
    SRCS "ble_svc.c"
    INCLUDE_DIRS "include"
    REQUIRES bt test_engine cell_profiles bts_link display esp_timer
)
