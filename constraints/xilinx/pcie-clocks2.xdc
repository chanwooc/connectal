
create_clock -name pci_refclk -period 10 [get_ports CLK_pci_sys_clk_p]
# create_clock -name sys_clk -period 5 [get_ports CLK_sys_clk_p]
# create_clock -name sys_clk1_300 -period 3.333 [get_ports CLK_sys_clk1_300_p]
# create_clock -name sys_clk2_300 -period 3.333 [get_ports CLK_sys_clk2_300_p]

set_max_delay -from [get_clocks {clkgen_pll_CLKOUT0}] -to   [get_clocks {userclk2}] [get_property PERIOD [get_clocks {userclk2}]] -datapath_only
set_max_delay -to   [get_clocks {clkgen_pll_CLKOUT0}] -from [get_clocks {userclk2}] [get_property PERIOD [get_clocks {userclk2}]]           -datapath_only

set_max_delay -from [get_clocks {clkgen_pll_CLKOUT2}] -to   [get_clocks {userclk2}] [get_property PERIOD [get_clocks {userclk2}]] -datapath_only
set_max_delay -to   [get_clocks {clkgen_pll_CLKOUT2}] -from [get_clocks {userclk2}] [get_property PERIOD [get_clocks {userclk2}]]           -datapath_only

# rename clock
create_generated_clock -name connectal_main_clock [get_pins *ep7/clkgen_pll/CLKOUT1]
# create_generated_clock -name connectal_derived_clock [get_pins *ep7/clkgen_pll/CLKOUT2]

set_max_delay -from [get_clocks {connectal_main_clock}] -to   [get_clocks {userclk2}] [get_property PERIOD [get_clocks {userclk2}]] -datapath_only
set_max_delay -to   [get_clocks {connectal_main_clock}] -from [get_clocks {userclk2}] [get_property PERIOD [get_clocks {userclk2}]]           -datapath_only

# set_max_delay -from [get_clocks {connectal_derived_clock}] -to   [get_clocks {userclk2}] [get_property PERIOD [get_clocks {userclk2}]] -datapath_only
# set_max_delay -to   [get_clocks {connectal_derived_clock}] -from [get_clocks {userclk2}] [get_property PERIOD [get_clocks {userclk2}]]           -datapath_only

set pcie125 [get_clocks -of_objects [get_pins *ep7/pcie_ep/inst/inst/gt_top_i/pipe_wrapper_i/pipe_clock_int.pipe_clock_i/mmcm_i/CLKOUT0]]
set pcie250 [get_clocks -of_objects [get_pins *ep7/pcie_ep/inst/inst/gt_top_i/pipe_wrapper_i/pipe_clock_int.pipe_clock_i/mmcm_i/CLKOUT1]]

set connectal_main [get_clocks connectal_main_clock];
# set connectal_derived [get_clocks connectal_derived_clock];

set_clock_groups -asynchronous -group $pcie125 -group $connectal_main
set_clock_groups -asynchronous -group $pcie250 -group $connectal_main
# set_clock_groups -asynchronous -group $pcie125 -group $connectal_derived
# set_clock_groups -asynchronous -group $pcie250 -group $connectal_derived

