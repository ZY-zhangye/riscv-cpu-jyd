module branch_predictor (
    input wire clk,
    input wire rst_n,
    //IF阶段输入
    input wire [31:0] pc_in,
    input wire [31:0] inst_in,
    //分支预测结果反馈
    input wire branch_result_valid,
    input wire [31:0] branch_pc,
    input wire branch_taken,
    input wire [31:0] branch_target,
    //预测结果输出
    output reg predict_valid,
    output reg predict_taken,
    output reg [31:0] predict_target
);

    parameter GHR_WIDTH = 8; // 全局历史寄存器宽度
    parameter PHT_SIZE = 256; // 分支预测表大小
    parameter BTB_SIZE = 256; // 分支历史表大小
    // 全局历史寄存器
    reg [GHR_WIDTH-1:0] ghr;
    // 分支预测表（PHT）
    reg [1:0] pht [0:PHT_SIZE-1]; // 2-bit saturating counter
    // 分支历史表（BTB）
    reg [31:0] btb_tag [0:BTB_SIZE-1];
    reg [31:0] btb_target [0:BTB_SIZE-1];
    reg btb_valid [0:BTB_SIZE-1];
    //IF阶段数据预处理
    wire [GHR_WIDTH-1:0] pht_index = pc_in[GHR_WIDTH+1:2] ^ ghr; // 使用PC和GHR的异或作为索引
    wire [GHR_WIDTH-1:0] btb_index = pc_in[GHR_WIDTH+1:2]; // 使用PC的某些位作为BTB索引
    wire [1:0] pht_state = pht[pht_index]; // 获取PHT状态
    wire btb_hit = btb_valid[btb_index] && (btb_tag[btb_index] == pc_in); // 判断BTB是否命中
    //简易译码，只译出其是否分支、跳转指令
    wire is_branch = (inst_in[6:0] == 7'b1100011); // B-type指令
    wire is_jump = (inst_in[6:0] == 7'b1101111) || (inst_in[6:0] == 7'b1100111); // JAL或JALR指令
    wire branch_or_jump = is_branch || is_jump; // 是否为分支或跳转指令

    //IF阶段分支预测逻辑
    always @ (*) begin
        predict_valid = branch_or_jump; // 只有分支或跳转指令才进行预测
        predict_taken = 0;
        predict_target = 0;
        if (branch_or_jump) begin
            predict_taken = pht_state[1]; // 预测是否跳转（根据PHT状态的最高位）
            if (is_jump) begin
                predict_taken = 1; // JAL和JALR指令总是预测为跳转
                if (btb_hit) begin
                    predict_target = btb_target[btb_index]; // 从BTB获取预测目标地址
                end else begin
                    predict_target = pc_in + 4; // 默认预测为下一条指令
                end
            end else if (is_branch) begin
                if (predict_taken && btb_hit) begin
                    predict_target = btb_target[btb_index]; // 从BTB获取预测目标地址
                end else begin
                    predict_target = pc_in + 4; // 默认预测为下一条指令
                end
            end
        end
    end
    //分支结果反馈更新逻辑
    task clean_up;
        integer i;
        begin
            for (i = 0; i < PHT_SIZE; i = i + 1) begin
                pht[i] = 2'b00; // 初始化PHT为强不跳转状态
            end
            for (i = 0; i < BTB_SIZE; i = i + 1) begin
                btb_valid[i] = 0; // 初始化BTB为无效状态
                btb_tag[i] = 0;
                btb_target[i] = 0;
            end
        end
    endtask
    task update_pht;
        integer index;
        begin
            index = branch_pc[GHR_WIDTH+1:2] ^ ghr; // 计算PHT索引
            case (pht[index])
                2'b00: pht[index] <= branch_taken ? 2'b01 : 2'b00; // 强不跳转
                2'b01: pht[index] <= branch_taken ? 2'b10 : 2'b00; // 弱不跳转
                2'b10: pht[index] <= branch_taken ? 2'b11 : 2'b01; // 弱跳转
                2'b11: pht[index] <= branch_taken ? 2'b11 : 2'b10; // 强跳转
            endcase
        end
    endtask
    task update_btb;
        integer index;
        begin
            index = branch_pc[GHR_WIDTH+1:2]; // 计算BTB索引
            btb_tag[index] <= branch_pc; // 更新BTB标签
            btb_target[index] <= branch_target; // 更新BTB目标地址
            btb_valid[index] <= 1; // 设置BTB条目为有效
        end
    endtask
    always @ (posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            ghr <= 0;
            clean_up(); // 复位时清空PHT和BTB
        end else if (branch_result_valid) begin
            ghr <= {ghr[GHR_WIDTH-2:0], branch_taken}; // 更新全局历史寄存器
            update_pht(); // 更新PHT
            update_btb(); // 更新BTB
        end
    end


endmodule