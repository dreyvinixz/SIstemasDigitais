## Clock signal (100 MHz)
set_property -dict { PACKAGE_PIN F14   IOSTANDARD LVCMOS33 } [get_ports { i_clk }];
create_clock -add -name sys_clk_pin -period 10.00 -waveform {0 5} [get_ports { i_clk }];

## Switches de controle (SW0 e SW1)
set_property -dict { PACKAGE_PIN U2   IOSTANDARD LVCMOS33 } [get_ports { i_sel_x }];
set_property -dict { PACKAGE_PIN V2   IOSTANDARD LVCMOS33 } [get_ports { i_sel_y }];

## Botões
set_property -dict { PACKAGE_PIN J2   IOSTANDARD LVCMOS33 } [get_ports { i_reset }];
set_property -dict { PACKAGE_PIN J5   IOSTANDARD LVCMOS33 } [get_ports { i_wrt }];

## Switches de dados (SW8-SW15)
set_property -dict { PACKAGE_PIN P1   IOSTANDARD LVCMOS33 } [get_ports { i_Datas[0] }];
set_property -dict { PACKAGE_PIN N2   IOSTANDARD LVCMOS33 } [get_ports { i_Datas[1] }];
set_property -dict { PACKAGE_PIN N1   IOSTANDARD LVCMOS33 } [get_ports { i_Datas[2] }];
set_property -dict { PACKAGE_PIN M2   IOSTANDARD LVCMOS33 } [get_ports { i_Datas[3] }];
set_property -dict { PACKAGE_PIN M1   IOSTANDARD LVCMOS33 } [get_ports { i_Datas[4] }];
set_property -dict { PACKAGE_PIN L1   IOSTANDARD LVCMOS33 } [get_ports { i_Datas[5] }];
set_property -dict { PACKAGE_PIN K2   IOSTANDARD LVCMOS33 } [get_ports { i_Datas[6] }];
set_property -dict { PACKAGE_PIN K1   IOSTANDARD LVCMOS33 } [get_ports { i_Datas[7] }];

## Display de 7 segmentos - Segmentos
set_property -dict { PACKAGE_PIN B5   IOSTANDARD LVCMOS33 } [get_ports { o_segments[0] }];
set_property -dict { PACKAGE_PIN D6   IOSTANDARD LVCMOS33 } [get_ports { o_segments[1] }];
set_property -dict { PACKAGE_PIN A7   IOSTANDARD LVCMOS33 } [get_ports { o_segments[2] }];
set_property -dict { PACKAGE_PIN B7   IOSTANDARD LVCMOS33 } [get_ports { o_segments[3] }];
set_property -dict { PACKAGE_PIN A5   IOSTANDARD LVCMOS33 } [get_ports { o_segments[4] }];
set_property -dict { PACKAGE_PIN C5   IOSTANDARD LVCMOS33 } [get_ports { o_segments[5] }];
set_property -dict { PACKAGE_PIN D7   IOSTANDARD LVCMOS33 } [get_ports { o_segments[6] }];

## Display de 7 segmentos - Anodos
set_property -dict { PACKAGE_PIN D5   IOSTANDARD LVCMOS33 } [get_ports { o_anodes[0] }];
set_property -dict { PACKAGE_PIN C4   IOSTANDARD LVCMOS33 } [get_ports { o_anodes[1] }];
set_property -dict { PACKAGE_PIN C7   IOSTANDARD LVCMOS33 } [get_ports { o_anodes[2] }];
set_property -dict { PACKAGE_PIN A8   IOSTANDARD LVCMOS33 } [get_ports { o_anodes[3] }];
