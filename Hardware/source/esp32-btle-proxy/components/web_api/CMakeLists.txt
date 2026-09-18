idf_component_register(
    SRCS "web_api.c" "wifi_mgr.c" "json_min.c"
    INCLUDE_DIRS "include"
    PRIV_INCLUDE_DIRS "."
    REQUIRES test_engine cell_profiles bts_link ble_svc
    PRIV_REQUIRES esp_http_server esp_wifi esp_netif esp_event nvs_flash esp_timer
)
