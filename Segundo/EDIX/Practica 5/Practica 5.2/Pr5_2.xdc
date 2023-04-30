## This file is a general .xdc for the Basys3 rev B board
## To use it in a project:
## - uncomment the lines corresponding to used pins
## - rename the used ports (in each line, after get_ports) according to the top level signal names in the project

## Configuration options, can be used for all designs
set_property CONFIG_VOLTAGE 3.3 [current_design]
set_property CFGBVS VCCO [current_design]

## Switches
set_property PACKAGE_PIN V16 [get_ports d[0]]
set_property IOSTANDARD LVCMOS33 [get_ports d[0]]

set_property PACKAGE_PIN W16 [get_ports d[1]]
set_property IOSTANDARD LVCMOS33 [get_ports d[1]]

set_property PACKAGE_PIN W17 [get_ports d[2]]
set_property IOSTANDARD LVCMOS33 [get_ports d[2]]

## LEDs
set_property PACKAGE_PIN U16 [get_ports q[0]]
set_property IOSTANDARD LVCMOS33 [get_ports q[0]]

set_property PACKAGE_PIN E19 [get_ports q[1]]
set_property IOSTANDARD LVCMOS33 [get_ports q[1]]

set_property PACKAGE_PIN U19 [get_ports q[2]]
set_property IOSTANDARD LVCMOS33 [get_ports q[2]]

set_property PACKAGE_PIN V19 [get_ports q[3]]
set_property IOSTANDARD LVCMOS33 [get_ports q[3]]

set_property PACKAGE_PIN W18 [get_ports q[4]]
set_property IOSTANDARD LVCMOS33 [get_ports q[4]]

set_property PACKAGE_PIN U15 [get_ports q[5]]
set_property IOSTANDARD LVCMOS33 [get_ports q[5]]

set_property PACKAGE_PIN U14 [get_ports q[6]]
set_property IOSTANDARD LVCMOS33 [get_ports q[6]]

set_property PACKAGE_PIN V14 [get_ports q[7]]
set_property IOSTANDARD LVCMOS33 [get_ports q[7]]