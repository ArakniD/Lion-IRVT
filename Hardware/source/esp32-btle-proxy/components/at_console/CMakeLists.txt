idf_component_register(
    SRCS "at_console.c"
         "bts_at_registers.c"
    INCLUDE_DIRS "include"
    PRIV_INCLUDE_DIRS "."
    REQUIRES bts_link driver esp_driver_uart
)
