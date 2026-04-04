vlib modelsim_lib/work
vlib modelsim_lib/msim

vlib modelsim_lib/msim/xil_defaultlib

vmap xil_defaultlib modelsim_lib/msim/xil_defaultlib

vlog -work xil_defaultlib  -incr -mfcu  "+incdir+../../../ipstatic" \
"../../../../digital_twin.gen/sources_1/ip/pll_1/pll_clk_wiz.v" \
"../../../../digital_twin.gen/sources_1/ip/pll_1/pll.v" \


vlog -work xil_defaultlib \
"glbl.v"

