# ps8_clockGen_pll_CLKOUT0 (connectal derived_clock) is derived from clk_pl_0 (connectal portal_clock)
# Two are marked asynch to each other to relieve timing efforts
set_clock_groups -asynchronous -group {clk_pl_0} -group {clk_pl_1} -group {ps8_clockGen_pll_CLKOUT0}
