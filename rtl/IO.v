`include "defines.v"
module IO (
    input wire clk,
    input wire rst_n,
    input wire [31:0] addr,
    input wire [31:0] wdata,
    input wire [3:0] wen,
    input wire ren,
    output reg [31:0] rdata,
    output reg [31:0] led,
    output reg [31:0] s,
    input wire [7:0] key,
    input wire [63:0] sw
);

    always @ (posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            rdata <= 32'b0;
            led <= 32'b0;
            s <= 32'b0;
        end else if (!wen) begin
            case (addr)
                `SWG_ADDR: begin
                    s[7:0] <= wen[0] ? wdata[7:0] : s[7:0]; 
                    s[15:8] <= wen[1] ? wdata[15:8] : s[15:8];
                    s[23:16] <= wen[2] ? wdata[23:16] : s[23:16];
                    s[31:24] <= wen[3] ? wdata[31:24] : s[31:24];
                end
                `LED_ADDR: begin
                    led[3:0] <= wen[0] ? wdata[3:0] : led[3:0]; 
                    led[7:4] <= wen[1] ? wdata[7:4] : led[7:4];
                    led[11:8] <= wen[2] ? wdata[11:8] : led[11:8];
                    led[15:12] <= wen[3] ? wdata[15:12] : led[15:12];
                end
                default: begin
                    s <= s; // 其他地址不修改s
                    led <= led; // 其他地址不修改led
                end
            endcase
        end else if (ren) begin
            case (addr)
                `KEY_ADDR: rdata <= {24'b0, key}; // 读键盘输入，扩展为32位
                `SW_LOW_ADDR: rdata <= sw[31:0]; // 读开关输入的低32位
                `SW_HIGH_ADDR: rdata <= sw[63:32]; // 读开关输入的高32位
                `LED_ADDR: rdata <= led; // 读LED状态
                `SWG_ADDR: rdata <= s; // 读SWG寄存器状态
                default: rdata <= 32'b0; // 其他地址读0
            endcase
        end else begin
            rdata <= 32'b0; // 没有读写操作时输出0
        end
    end

endmodule