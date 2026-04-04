`include "defines.v"
module my_cpu
(
    input wire clk,
    input wire clk_cnt,
    input wire rst_n,
    `ifdef DEBUG_INTERFACE_ENABLE
    //debug接口
    output wire [31:0] debug_inst_pc,
    output wire [31:0] debug_wb_pc,
    output wire debug_wb_rf_wen,
    output wire [4:0] debug_wb_rf_wnum,
    output wire [31:0] debug_wb_rf_wdata,
    output wire [31:0] debug_data,
    `endif
    //外设接口
    output wire [31:0] led,
    input wire [7:0] key,
    input wire [63:0] sw,
    output wire [39:0] seg
);
wire [31:0] imem_addr;
wire [31:0] imem_rdata;
wire imem_ren;
wire [31:0] dmem_addr;
wire [31:0] dmem_wdata;
wire [3:0] dmem_wen;
wire [31:0] dmem_rdata;
wire dmem_en;

wire inst_ram_ren;
wire [31:0] inst_ram_addr;
wire [31:0] inst_ram_rdata;
wire inst_ram_wen;
wire [31:0] inst_ram_wdata;
wire data_ram_ren;
wire [31:0] data_ram_addr;
wire [31:0] data_ram_rdata;
wire [3:0]  data_ram_wen;
wire [31:0] data_ram_wdata;
wire io_ren;
wire [31:0] io_addr;
wire [31:0] io_rdata;
wire [3:0] io_wen;
wire [31:0] io_wdata;
wire [31:0] s; // SWG寄存器


`ifdef DEBUG_INTERFACE_ENABLE
assign debug_inst_pc = imem_addr - 4;
`endif

cpu_top u_top(
    .clk(clk),
    .rst_n(rst_n),
    `ifdef DEBUG_INTERFACE_ENABLE
    .debug_wb_pc(debug_wb_pc),
    .debug_wb_rf_wen(debug_wb_rf_wen),
    .debug_wb_rf_wnum(debug_wb_rf_wnum),
    .debug_wb_rf_wdata(debug_wb_rf_wdata),
    .debug_data(debug_data),
    `endif
    .imem_addr(imem_addr),
    .imem_rdata(imem_rdata),
    .imem_ren(imem_ren),
    .dmem_addr(dmem_addr),
    .dmem_wdata(dmem_wdata),
    .dmem_wen(dmem_wen),
    .dmem_rdata(dmem_rdata),
    .dmem_en(dmem_en)
);

bridge u_bridge(
    .clk(clk),
    .rst_n(rst_n),
    .inst_ram_ren(inst_ram_ren),
    .inst_ram_addr(inst_ram_addr),
    .inst_ram_rdata(inst_ram_rdata),
    .inst_ram_wen(inst_ram_wen),
    .inst_ram_wdata(inst_ram_wdata),
    .data_ram_ren(data_ram_ren),
    .data_ram_addr(data_ram_addr),
    .data_ram_rdata(data_ram_rdata),
    .data_ram_wen(data_ram_wen),
    .data_ram_wdata(data_ram_wdata),
    .imem_addr(imem_addr),
    .imem_rdata(imem_rdata),
    .imem_ren(imem_ren),
    .dmem_addr(dmem_addr),
    .dmem_wdata(dmem_wdata),
    .dmem_wen(dmem_wen),
    .dmem_rdata(dmem_rdata),
    .dmem_en(dmem_en),
    .io_ren(io_ren),
    .io_addr(io_addr),
    .io_rdata(io_rdata),
    .io_wen(io_wen),
    .io_wdata(io_wdata)
);

IO u_io(
    .clk(clk),
    .clk_cnt(clk_cnt),
    .rst_n(rst_n),
    .ren(io_ren),
    .addr(io_addr),
    .rdata(io_rdata),
    .wen(io_wen),
    .wdata(io_wdata),
    .led(led),
    .key(key),
    .sw(sw),
    .s(s)
);

inst_ram u_inst_ram
(
    .clk(clk),
    .rst_n(rst_n),
    .inst_ram_ren(inst_ram_ren),
    .inst_ram_addr(inst_ram_addr),
    .inst_ram_rdata(inst_ram_rdata),
    .inst_ram_wen(inst_ram_wen),
    .inst_ram_wdata(inst_ram_wdata)
);

data_ram u_data_ram
(
    .clk(clk),
    .rst_n(rst_n),
    .data_ram_ren(data_ram_ren),
    .data_ram_addr(data_ram_addr),
    .data_ram_rdata(data_ram_rdata),
    .data_ram_wen(data_ram_wen),
    .data_ram_wdata(data_ram_wdata)
);

display_seg u_display_seg(
    .clk(clk),
    .rst(~rst_n),
    .s(s),
    .seg1(seg[6:0]),
    .seg2(seg[16:10]),
    .seg3(seg[26:20]),
    .seg4(seg[36:30]),
    .ans({seg[39:38], seg[29:28], seg[19:18], seg[9:8]})
);
assign seg[7] = 1'b0; // 小数点不使用
assign seg[17] = 1'b0;
assign seg[27] = 1'b0;
assign seg[37] = 1'b0;

endmodule