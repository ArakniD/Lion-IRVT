idf_component_register(
    SRCS "web_api.c" "wifi_mgr.c" "json_min.c"
    INCLUDE_DIRS "include"
    PRIV_INCLUDE_DIRS "."
    REQUIRES test_engine cell_profiles bts_link ble_svc ota
    PRIV_REQUIRES esp_http_server esp_wifi esp_netif esp_event nvs_flash esp_timer
    # The setup page, linked into the image as _binary_index_html_start/_end.
    # TXTFILES rather than FILES so a NUL is appended and the page can be sent
    # as a C string; web_api.c subtracts it from the length.
    EMBED_TXTFILES "www/index.html"
)
