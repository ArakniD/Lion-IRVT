idf_component_register(
    SRCS "led_strip.c"
    INCLUDE_DIRS "include"
    REQUIRES bts_link
    PRIV_REQUIRES esp_driver_spi
)
