`include "defines.v"
module bridge (
    input wire clk,
    input wire rst_n,
    // 指令寄存器读写信号
    output inst_ram_ren,
    output [31:0] inst_ram_addr,
    input wire [31:0] inst_ram_rdata,
    output inst_ram_wen,
    output [31:0] inst_ram_wdata,
    // 数据寄存器读写信号
    output data_ram_ren,
    output [31:0] data_ram_addr,
    input wire [31:0] data_ram_rdata,
    output [3:0] data_ram_wen,
    output [31:0] data_ram_wdata,
    // IO接口
    output io_ren,
    output [31:0] io_addr,
    input wire [31:0] io_rdata,
    output [3:0] io_wen,
    output [31:0] io_wdata,
    // 来自top的寄存器读写信号
    input wire [31:0] imem_addr,
    output wire [31:0] imem_rdata,
    input wire imem_ren,
    input wire [31:0] dmem_addr,
    input wire [31:0] dmem_wdata,
    input wire [3:0] dmem_wen,
    output wire [31:0] dmem_rdata,
    input wire dmem_en
);

// 指令寄存器接口（无修改）
assign inst_ram_ren = imem_ren;
assign inst_ram_addr = imem_addr;
assign imem_rdata = inst_ram_rdata;
assign inst_ram_wen = 1'b0; // 指令寄存器不写
assign inst_ram_wdata = 32'b0; // 不写数据


`ifdef DEBUG_INTERFACE_ENABLE
// Debug模式：全部映射到data_ram，IO接口无效
assign data_ram_ren   = dmem_en;
assign data_ram_addr  = dmem_addr;
assign data_ram_wen   = dmem_wen;
assign data_ram_wdata = dmem_wdata;
assign io_ren   = 1'b0;
assign io_addr  = 32'b0;
assign io_wen   = 4'b0;
assign io_wdata = 32'b0;
assign dmem_rdata = data_ram_rdata;
`else
// 地址划分
wire is_data_ram = (dmem_addr >= 32'h8010_0000) && (dmem_addr < 32'h8013_FFFF);
wire is_io      = (dmem_addr >= 32'h8020_0000) && (dmem_addr <= 32'h8020_00FF);
reg is_data_ram_reg;
reg is_io_reg;
always @ (posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        is_data_ram_reg <= 1'b0;
        is_io_reg <= 1'b0;
    end else begin
        is_data_ram_reg <= is_data_ram;
        is_io_reg <= is_io;
    end
end
// data_ram接口
assign data_ram_ren   = dmem_en && is_data_ram;
assign data_ram_addr  = dmem_addr;
assign data_ram_wen   = is_data_ram ? dmem_wen : 4'b0000;
assign data_ram_wdata = dmem_wdata;
// IO接口
assign io_ren   = dmem_en && is_io;
assign io_addr  = dmem_addr;
assign io_wen   = is_io ? dmem_wen : 4'b0000;
assign io_wdata = dmem_wdata;
// 读数据返回
assign dmem_rdata = is_data_ram_reg ? data_ram_rdata :
                    is_io_reg      ? io_rdata       : 32'b0;
`endif

endmodule