"""
bts_i2c component for ESPHome.

Integrates the BTS I2C library for communication with the TI C2000 F28379D-based battery testing system.
"""

from esphome import automation
from esphome.components import esphome
from esphome.const import CONF_ID
import esphome.config_validation as cv
import esphome.codegen as cg

bts_i2c_ns = cg.esphome_ns.namespace("bts_i2c")
BTSI2CComponent = bts_i2c_ns.class_("BTSI2CComponent", cg.Component)

CONFIG_SCHEMA = cv.Schema({
    cv.GenerateID(): cv.declare_id(BTSI2CComponent),
}).extend(cv.COMPONENT_SCHEMA)

async def to_code(config):
    var = cg.new_Pvariable(config[CONF_ID])
    await cg.register_component(var, config)