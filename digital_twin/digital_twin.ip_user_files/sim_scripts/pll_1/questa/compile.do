vlib questa_lib/work
vlib questa_lib/msim

vlib questa_lib/msim/xil_defaultlib

vmap xil_defaultlib questa_lib/msim/xil_defaultlib

vlog -work xil_defaultlib  -incr -mfcu  "+incdir+../../../ipstatic" \
"../../../../digital_twin.gen/sources_1/ip/pll_1/pll_clk_wiz.v" \
"../../../../digital_twin.gen/sources_1/ip/pll_1/pll.v" \


vlog -work xil_defaultlib \
"glbl.v"

