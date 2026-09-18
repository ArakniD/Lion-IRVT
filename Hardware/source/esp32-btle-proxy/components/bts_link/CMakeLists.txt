idf_component_register(
    SRCS "bts_link.c"
    INCLUDE_DIRS "include"
    REQUIRES driver esp_driver_i2c esp_driver_gpio esp_timer
)
