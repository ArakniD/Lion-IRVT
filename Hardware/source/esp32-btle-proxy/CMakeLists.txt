# ESP-IDF top-level project file for the BTS BLE/WiFi proxy.
#
# Target: LiLion32 v1.0.0 (ESP-WROOM-32 module + integrated Li-ion charger).
# Build with ESP-IDF v6.1 (C:\esp\v6.1\esp-idf).

cmake_minimum_required(VERSION 3.16)

include($ENV{IDF_PATH}/tools/cmake/project.cmake)

project(bts_btle_proxy)
