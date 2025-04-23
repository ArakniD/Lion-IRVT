/**
 * bluetooth_hid.h
 *
 * ESPHome component for Bluetooth HID host to connect to Intermec SR61B scanner.
 *
 * Created on: April 21, 2025
 * Author: Grok
 */

#pragma once

#include "esphome/core/component.h"
#include "esphome/core/automation.h"
#include <esp_bt.h>
#include <esp_bt_main.h>
#include <esp_hidh.h>
#include <string>

namespace esphome {
namespace bluetooth_hid {

class BluetoothHIDComponent : public Component {
public:
  void setup() override;
  void loop() override;
  void dump_config() override;

  void set_mac_address(const std::string &mac);
  void set_pairing_code(const std::string &code);

  // Trigger for text events
  Trigger<std::string> *get_text_trigger() { return &text_trigger_; }

  // Public members for callback access
  esp_hidh_dev_t *device_ = nullptr;
  void handle_hid_input(uint8_t *data, size_t length);

  // Typedef for HID callback signature
  using hid_callback_t = void (*)(esp_hidh_dev_t*, esp_hidh_event_t, void*, esp_hidh_event_data_t*);

protected:
  std::string mac_address_;
  std::string pairing_code_;
  Trigger<std::string> text_trigger_; // Trigger for received text
};

}  // namespace bluetooth_hid
}  // namespace esphome