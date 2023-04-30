## This file is a general .xdc for the Basys3 rev B board
## To use it in a project:
## - uncomment the lines corresponding to used pins
## - rename the used ports (in each line, after get_ports) according to the top level signal names in the project

## Configuration options, can be used for all designs
set_property CONFIG_VOLTAGE 3.3 [current_design]
set_property CFGBVS VCCO [current_design]

## Switches
set_property PACKAGE_PIN V17 [get_ports a[0]]
set_property IOSTANDARD LVCMOS33 [get_ports a[0]]

set_property PACKAGE_PIN V16 [get_ports a[1]]
set_property IOSTANDARD LVCMOS33 [get_ports a[1]]

set_property PACKAGE_PIN W16 [get_ports a[2]]
set_property IOSTANDARD LVCMOS33 [get_ports a[2]]

set_property PACKAGE_PIN W17 [get_ports a[3]]
set_property IOSTANDARD LVCMOS33 [get_ports a[3]]

## LEDs
set_property PACKAGE_PIN U16 [get_ports f1]
set_property IOSTANDARD LVCMOS33 [get_ports f1]

set_property PACKAGE_PIN E19 [get_ports f2]
set_property IOSTANDARD LVCMOS33 [get_ports f2]

set_property PACKAGE_PIN U19 [get_ports f3]
set_property IOSTANDARD LVCMOS33 [get_ports f3]