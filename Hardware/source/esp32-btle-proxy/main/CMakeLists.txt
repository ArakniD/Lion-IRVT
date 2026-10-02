idf_component_register(
    SRCS "main.c"
    INCLUDE_DIRS "."
    REQUIRES bts_link cell_profiles test_engine ble_svc web_api display input led_strip at_console nvs_flash esp_event
)
