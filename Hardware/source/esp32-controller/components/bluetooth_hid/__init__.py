"""
bluetooth_hid component for ESPHome.

Handles Bluetooth HID host connection to Intermec SR61B scanner.
"""

from esphome import automation
from esphome.components import esphome
from esphome.const import CONF_ID, CONF_MAC_ADDRESS
import esphome.config_validation as cv
import esphome.codegen as cg

bluetooth_hid_ns = cg.esphome_ns.namespace("bluetooth_hid")
BluetoothHIDComponent = bluetooth_hid_ns.class_("BluetoothHIDComponent", cg.Component)

CONF_ON_TEXT = "on_text"  # Custom configuration key for text trigger

CONFIG_SCHEMA = cv.Schema({
    cv.GenerateID(): cv.declare_id(BluetoothHIDComponent),
    cv.Required(CONF_MAC_ADDRESS): cv.mac_address,
    cv.Optional("pairing_code"): cv.string,
    cv.Optional(CONF_ON_TEXT): automation.validate_automation(single=True),
}).extend(cv.COMPONENT_SCHEMA)

async def to_code(config):
    var = cg.new_Pvariable(config[CONF_ID])
    await cg.register_component(var, config)
    
    # Convert MACAddress to string using str()
    cg.add(var.set_mac_address(str(config[CONF_MAC_ADDRESS])))
    if "pairing_code" in config:
        cg.add(var.set_pairing_code(config["pairing_code"]))
    
    if CONF_ON_TEXT in config:
        await automation.build_automation(
            var.get_text_trigger(),
            [(cg.std_string, "x")],
            config[CONF_ON_TEXT],
        )