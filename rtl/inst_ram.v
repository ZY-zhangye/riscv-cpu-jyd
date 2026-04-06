`include "defines.v"
module inst_ram #(
    parameter MEM_HEX_PATH = `TEST_INST_PATH
)
(
    input wire clk,
    input wire rst_n,
    //指令寄存器接口
    input wire inst_ram_ren,
    input wire [31:0] inst_ram_addr,
    output reg [31:0] inst_ram_rdata,
    input wire inst_ram_wen,
    input wire [31:0] inst_ram_wdata
);

reg [31:0] mem [0:2048-1]; // 512KB字节寻址空间，按字对齐访问
task automatic load_mem;
    integer i;
    begin
        for (i = 0; i < 2048; i = i + 1) begin
            mem[i] = 32'b0;
        end
        $readmemh(MEM_HEX_PATH, mem);
    end
endtask
initial begin
    load_mem();
end

always @ (posedge clk) begin
    if (inst_ram_ren) begin
        inst_ram_rdata <= mem[inst_ram_addr[12:2]]; // 按字对齐访问
    end
    if (inst_ram_wen) begin
        mem[inst_ram_addr[12:2]] <= inst_ram_wdata; // 按字对齐访问
    end
end

endmodule