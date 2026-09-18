idf_component_register(
    SRCS "display.c" "ui_font.c"
    INCLUDE_DIRS "include"
    PRIV_INCLUDE_DIRS "."
    REQUIRES test_engine bts_link web_api input
    PRIV_REQUIRES esp_lcd esp_driver_spi esp_driver_gpio esp_timer
)
