idf_component_register(
    SRCS "ota.c"
    INCLUDE_DIRS "include"
    REQUIRES bts_link
    PRIV_REQUIRES app_update esp_app_format bootloader_support nvs_flash esp_timer
)
