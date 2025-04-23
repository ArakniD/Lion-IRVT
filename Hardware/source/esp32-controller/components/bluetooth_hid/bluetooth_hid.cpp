/**
 * bluetooth_hid.cpp
 *
 * Implementation of Bluetooth HID host component.
 *
 * Created on: April 21, 2025
 * Author: Grok
 */

#include "bluetooth_hid.h"
#include "esphome/core/log.h"

namespace esphome {
namespace bluetooth_hid {

static const char *TAG = "bluetooth_hid";

// Static callback function for HID events
static void hid_event_handler(void *handler_args, esp_event_base_t base, int32_t event_id, void *event_data) {
  if (base != ESP_HIDH_EVENTS) {
    return;
  }

  esp_hidh_event_t event = static_cast<esp_hidh_event_t>(event_id);
  esp_hidh_event_data_t *param = static_cast<esp_hidh_event_data_t *>(event_data);
  auto *self = static_cast<BluetoothHIDComponent *>(handler_args);

  switch (event) {
    case ESP_HIDH_OPEN_EVENT:
      ESP_LOGI(TAG, "HID device connected");
      self->device_ = param->open.dev;
      break;
    case ESP_HIDH_CLOSE_EVENT:
      ESP_LOGI(TAG, "HID device disconnected");
      self->device_ = nullptr;
      break;
    case ESP_HIDH_INPUT_EVENT:
      ESP_LOGD(TAG, "HID input received, length: %d", param->input.length);
      self->handle_hid_input(param->input.data, param->input.length);
      break;
    default:
      ESP_LOGD(TAG, "Unhandled HID event: %d", event);
      break;
  }
}

void BluetoothHIDComponent::setup() {
  // Initialize Bluetooth
  esp_err_t ret;
  ret = esp_bt_controller_mem_release(ESP_BT_MODE_BLE);
  if (ret) {
    ESP_LOGE(TAG, "Bluetooth controller memory release failed: %s", esp_err_to_name(ret));
    return;
  }

  esp_bt_controller_config_t bt_cfg = BT_CONTROLLER_INIT_CONFIG_DEFAULT();
  ret = esp_bt_controller_init(&bt_cfg);
  if (ret) {
    ESP_LOGE(TAG, "Bluetooth controller init failed: %s", esp_err_to_name(ret));
    return;
  }

  ret = esp_bt_controller_enable(ESP_BT_MODE_CLASSIC_BT);
  if (ret) {
    ESP_LOGE(TAG, "Bluetooth controller enable failed: %s", esp_err_to_name(ret));
    return;
  }

  ret = esp_bluedroid_init();
  if (ret) {
    ESP_LOGE(TAG, "Bluedroid init failed: %s", esp_err_to_name(ret));
    return;
  }

  ret = esp_bluedroid_enable();
  if (ret) {
    ESP_LOGE(TAG, "Bluedroid enable failed: %s", esp_err_to_name(ret));
    return;
  }

  // Initialize HID host
  esp_hidh_config_t config = {
      .callback = hid_event_handler,
      .callback_arg = this
  };
  ESP_LOGD(TAG, "Initializing HID host");
  ret = esp_hidh_init(&config);
  if (ret) {
    ESP_LOGE(TAG, "HID host init failed: %s", esp_err_to_name(ret));
    return;
  }

  // Connect to SR61B
  esp_bd_addr_t bda;
  sscanf(mac_address_.c_str(), "%hhx:%hhx:%hhx:%hhx:%hhx:%hhx",
         &bda[0], &bda[1], &bda[2], &bda[3], &bda[4], &bda[5]);
  device_ = esp_hidh_dev_open(bda, ESP_HID_TRANSPORT_BT, ESP_HID_COD_MIN_KEYBOARD);
  if (!device_) {
    ESP_LOGE(TAG, "Failed to open HID device");
  }
}

void BluetoothHIDComponent::loop() {
  // Handle reconnection
  if (!device_) {
    esp_bd_addr_t bda;
    sscanf(mac_address_.c_str(), "%hhx:%hhx:%hhx:%hhx:%hhx:%hhx",
           &bda[0], &bda[1], &bda[2], &bda[3], &bda[4], &bda[5]);
    device_ = esp_hidh_dev_open(bda, ESP_HID_TRANSPORT_BT, ESP_HID_COD_MIN_KEYBOARD);
    if (device_) {
      ESP_LOGI(TAG, "Reconnected to HID device");
    }
  }
}

void BluetoothHIDComponent::dump_config() {
  ESP_LOGCONFIG(TAG, "Bluetooth HID Component:");
  ESP_LOGCONFIG(TAG, "  MAC Address: %s", mac_address_.c_str());
  ESP_LOGCONFIG(TAG, "  Pairing Code: %s", pairing_code_.c_str());
}

void BluetoothHIDComponent::set_mac_address(const std::string &mac) {
  mac_address_ = mac;
}

void BluetoothHIDComponent::set_pairing_code(const std::string &code) {
  pairing_code_ = code;
  // Pairing code is typically handled during initial pairing via system Bluetooth settings
}

void BluetoothHIDComponent::handle_hid_input(uint8_t *data, size_t length) {
  // Convert HID keyboard input to ASCII
  std::string text;
  for (size_t i = 0; i < length; i++) {
    if (data[i] >= 0x04 && data[i] <= 0x1D) { // Letters a-z
      text += (char)('a' + (data[i] - 0x04));
    } else if (data[i] >= 0x1E && data[i] <= 0x27) { // Numbers 1-0
      text += (char)('1' + (data[i] - 0x1E));
      if (data[i] == 0x27) text[text.length() - 1] = '0';
    } else if (data[i] == 0x2D) { // Hyphen
      text += '-';
    }
  }
  if (!text.empty()) {
    ESP_LOGD(TAG, "Received HID input: %s", text.c_str());
    text_trigger_.trigger(text); // Trigger the ESPHome automation
  }
}

}  // namespace bluetooth_hid
}  // namespace esphome