#include "esphome/core/component.h"
#include "bts_i2c.h" // Defines BTSI2C and ChannelStatus

namespace esphome {
namespace bts_i2c {

class BTSI2CComponent : public Component {
 public:
  void setup() override {
    bts_.begin(); // Initialize the BTSI2C object if needed
  }

  // Delegated methods
  ChannelStatus read_status(uint8_t channel) { return bts_.read_status(channel); }
  float read_voltage(uint8_t channel) { return bts_.read_voltage(channel); }
  float read_current(uint8_t channel) { return bts_.read_current(channel); }
  float read_temperature(uint8_t channel) { return bts_.read_temperature(channel); }
  void set_mode(uint8_t channel, bool enable, bool charge) {
    bts_.set_mode(channel, enable, charge);
  }
  void apply_samsung_25r_profile(uint8_t channel) { bts_.apply_samsung_25r_profile(channel); }
  void apply_samsung_20q_profile(uint8_t channel) { bts_.apply_samsung_20q_profile(channel); }

 private:
  BTSI2C bts_; // The underlying I2C device interface
};

}  // namespace bts_i2c
}  // namespace esphome