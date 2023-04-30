## Configuration options, can be used for all designs
set_property CONFIG_VOLTAGE 3.3 [current_design]
set_property CFGBVS VCCO [current_design]

## Switches
set_property PACKAGE_PIN V17 [get_ports d]
set_property IOSTANDARD LVCMOS33 [get_ports d]

set_property PACKAGE_PIN V16 [get_ports c]
set_property IOSTANDARD LVCMOS33 [get_ports c]

set_property PACKAGE_PIN W16 [get_ports b]
set_property IOSTANDARD LVCMOS33 [get_ports b]

set_property PACKAGE_PIN W17 [get_ports a]
set_property IOSTANDARD LVCMOS33 [get_ports a]

## LEDs
set_property PACKAGE_PIN U16 [get_ports Y]
set_property IOSTANDARD LVCMOS33 [get_ports Y]