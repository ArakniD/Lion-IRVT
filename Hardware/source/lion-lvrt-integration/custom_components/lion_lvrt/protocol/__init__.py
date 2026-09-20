"""Transport-independent codecs for the BTS interfaces.

Split by wire format rather than by feature: :mod:`.ble` covers the
little-endian GATT records, :mod:`.registers` the big-endian I2C/HTTP
register map, and :mod:`.can` the mixed-endian CAN frames. Nothing in this
package imports Home Assistant, so it is testable standalone.
"""
