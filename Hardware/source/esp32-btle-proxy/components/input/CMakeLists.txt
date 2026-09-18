idf_component_register(
    SRCS "input.c"
    INCLUDE_DIRS "include"
    PRIV_REQUIRES esp_driver_pcnt esp_driver_gpio esp_timer
)
