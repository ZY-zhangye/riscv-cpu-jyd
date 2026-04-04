`include "defines.v"
module IO (
    input wire clk,
    input wire clk_cnt,
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

    function [31:0] gray2bin;
        input [31:0] gray;
        integer i;
        begin
            gray2bin[31] = gray[31];
            for (i = 30; i >= 0; i = i - 1) begin
                gray2bin[i] = gray2bin[i + 1] ^ gray[i];
            end
        end
    endfunction

    // clk域：外设寄存器读写；clk_cnt域：计数器递增
    reg cnt_en_req;         // clk域写入的计数使能请求
    reg cnt_en_cnt_ff1;     // 同步到clk_cnt域的第一级
    reg cnt_en_cnt_ff2;     // 同步到clk_cnt域的第二级
    reg cnt_en_cnt_prev;    // 用于检测启动沿
    reg [31:0] cnt_bin;     // clk_cnt域中的真实计数值（每1ms+1）
    reg [15:0] ms_cnt;      // 1ms分频计数器（50MHz -> 1kHz）
    reg [31:0] cnt_gray_ff1;
    reg [31:0] cnt_gray_ff2;
    reg [31:0] cnt;

    wire io_wen = |wen; // 只要有一个写使能位被置位，就认为是写操作
    wire [31:0] cnt_gray = cnt_bin ^ (cnt_bin >> 1);
    wire [31:0] cnt_read = gray2bin(cnt_gray_ff2);

    always @ (posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            rdata <= 32'b0;
            led <= 32'b0;
            s <= 32'b0;
            cnt_en_req <= 1'b0;
            cnt_gray_ff1 <= 32'b0;
            cnt_gray_ff2 <= 32'b0;
            cnt <= 32'b0;
        end else begin
            // 将clk_cnt域计数值同步回clk域，供CPU读出
            cnt_gray_ff1 <= cnt_gray;
            cnt_gray_ff2 <= cnt_gray_ff1;
            cnt <= cnt_read;

            if (io_wen) begin
                case (addr)
                    `SEG_ADDR: begin
                        s <= wdata; // 写入SEG寄存器
                    end
                    `LED_ADDR: begin
                        led <= wdata; // 写入LED寄存器
                    end
                    `CNT_ADDR: begin
                        if (wdata == 32'h80000000) begin
                            cnt_en_req <= 1'b1; // 开始计数
                        end else if (wdata == 32'hFFFFFFFF) begin
                            cnt_en_req <= 1'b0; // 结束计数
                        end
                    end
                    default: begin
                        // 保持原值
                    end
                endcase
            end else if (ren) begin
                case (addr)
                    `KEY_ADDR: rdata <= {24'b0, key}; // 读键盘输入，扩展为32位
                    `SW_LOW_ADDR: rdata <= sw[31:0]; // 读开关输入的低32位
                    `SW_HIGH_ADDR: rdata <= sw[63:32]; // 读开关输入的高32位
                    `LED_ADDR: rdata <= led; // 读LED状态
                    `SEG_ADDR: rdata <= s; // 读SEG寄存器状态
                    `CNT_ADDR: rdata <= cnt; // 读同步后的计数器当前值
                    default: rdata <= 32'b0; // 其他地址读0
                endcase
            end else begin
                rdata <= 32'b0; // 没有读写操作时输出0
            end
        end
    end

    // 计数器递增逻辑：50MHz clk_cnt域
    always @ (posedge clk_cnt or negedge rst_n) begin
        if (!rst_n) begin
            cnt_en_cnt_ff1 <= 1'b0;
            cnt_en_cnt_ff2 <= 1'b0;
            cnt_en_cnt_prev <= 1'b0;
            cnt_bin <= 32'b0;
            ms_cnt <= 16'b0;
        end else begin
            cnt_en_cnt_ff1 <= cnt_en_req;
            cnt_en_cnt_ff2 <= cnt_en_cnt_ff1;
            cnt_en_cnt_prev <= cnt_en_cnt_ff2;

            if (!cnt_en_cnt_prev && cnt_en_cnt_ff2) begin
                cnt_bin <= 32'b0; // 启动时清零
                ms_cnt <= 16'b0;
            end else if (cnt_en_cnt_ff2) begin
                if (ms_cnt == 16'd49999) begin // 50,000 cycles = 1ms @ 50MHz
                    ms_cnt <= 16'b0;
                    cnt_bin <= cnt_bin + 1'b1;
                end else begin
                    ms_cnt <= ms_cnt + 1'b1;
                end
            end else begin
                ms_cnt <= 16'b0;
            end
        end
    end

endmodule
