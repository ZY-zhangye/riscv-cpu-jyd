transcript off
onbreak {quit -force}
onerror {quit -force}
transcript on

vlib work
vlib activehdl/xil_defaultlib

vmap xil_defaultlib activehdl/xil_defaultlib

vlog -work xil_defaultlib  -v2k5 "+incdir+../../../ipstatic" -l xil_defaultlib \
"../../../../digital_twin.gen/sources_1/ip/pll_1/pll_clk_wiz.v" \
"../../../../digital_twin.gen/sources_1/ip/pll_1/pll.v" \


vlog -work xil_defaultlib \
"glbl.v"

