`include "defines.v"
module exe_stage (
    input wire clk,
    input wire rst_n,
    //握手信号
    input wire ds_to_es_valid,
    output wire es_allowin,
    output wire es_to_ms_valid,
    input wire ms_allowin,
    //来自译码阶段的总线
    input wire [`DS_TO_ES_BUS_WD-1:0] id_exe_bus_in,
    //输出到访存阶段的总线
    output wire [`ES_TO_MS_BUS_WD-1:0] exe_mem_bus_out,
    //数据存储器接口
    output wire data_sram_en,
    output wire [3:0] data_sram_wen,
    output wire [31:0] data_sram_addr,
    output wire [31:0] data_sram_wdata,
    //数据前递路径
    output wire [31:0] exe_id_data,
    output wire [4:0] exe_id_waddr,
    output wire exe_id_we,
    output wire exe_id_es_valid,
    output wire [31:0] exe_id_csr_wdata,
    output wire exe_id_csr_we,
    output wire [11:0] exe_id_csr_addr,
    //跳转指令与分支指令的目标地址与信号
    output wire [31:0] br_target,
    output wire br_taken,
    //异常相关信号
    input wire [5:0] exception_code_de,
    input wire [31:0] exception_mtval_de,
    output wire [5:0] exception_code_em,
    output wire [31:0] exception_mtval_em,
    input wire exception_flag
);

wire es_ready_go = 1'b1; // EXE 阶段无内部停顿，始终准备好
reg es_valid;
assign exe_id_es_valid = es_valid; // 将EXE阶段的有效信号传递给ID阶段，用于数据前递和冒险检测
assign es_allowin = !es_valid || es_ready_go && ms_allowin;
assign es_to_ms_valid = es_valid && es_ready_go;
always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        es_valid <= 1'b0;
    end else if (es_allowin) begin
        es_valid <= ds_to_es_valid;
    end
end

// 从译码阶段传来的控制与数据信号
reg [`DS_TO_ES_BUS_WD-1:0] ds_to_es_bus_r;
reg [5:0] exception_code_reg;
reg [31:0] exception_mtval_reg;
always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        ds_to_es_bus_r <= 0;
        exception_code_reg <= 0;
        exception_mtval_reg <= 0;
    end else if (es_allowin && ds_to_es_valid) begin
        if (exception_flag || br_taken) begin
            ds_to_es_bus_r <= 0; // 发生异常时，EXE阶段输出NOP
            exception_code_reg <= 0;
            exception_mtval_reg <= 0;
        end else begin
            ds_to_es_bus_r <= id_exe_bus_in; // 正常传递控制与数据
            exception_code_reg <= exception_code_de;
            exception_mtval_reg <= exception_mtval_de;
        end
    end
end

// 从打包总线中解包出的控制与数据信号
wire [31:0] exe_pc;
wire [31:0] exe_imm;
wire [31:0] exe_rs1_data;
wire [31:0] exe_rs2_data;
wire [2:0] exe_op1_sel;
wire [1:0] exe_op2_sel;
wire [12:0] exe_alu_op;
wire [2:0] exe_br_type;
wire exe_jmp_flag;
wire exe_rd_wen;
wire [4:0] exe_rd_addr;
wire [1:0] exe_wb_sel;
wire [3:0] exe_csr_cmd;
wire exe_csr_we;
wire [11:0] exe_csr_addr;
wire [31:0] csr_rdata;
wire exe_mem_we;
wire exe_mem_re;
wire [2:0] exe_mem_size;
assign {
    exe_pc,
    exe_imm,
    exe_rs1_data,
    exe_rs2_data,
    exe_op1_sel,
    exe_op2_sel,
    exe_alu_op,
    exe_br_type,
    exe_jmp_flag,
    exe_rd_wen,
    exe_rd_addr,
    exe_wb_sel,
    exe_csr_cmd,
    exe_csr_we,
    exe_csr_addr,
    csr_rdata,
    exe_mem_we,
    exe_mem_re,
    exe_mem_size
} = ds_to_es_bus_r;

// ALU操作数选择 - 并行掩码合并结构（降低选择链深度）
wire [31:0] op1_data;
wire [31:0] op2_data;

// op1_data优先级保持不变: sel[2] > sel[0] > sel[1] > default(rs1)
wire op1_sel_rs1 = exe_op1_sel[2] | (~exe_op1_sel[2] & ~exe_op1_sel[0] & ~exe_op1_sel[1]);
wire op1_sel_pc  = ~exe_op1_sel[2] & ~exe_op1_sel[0] &  exe_op1_sel[1];
wire op1_sel_imm = ~exe_op1_sel[2] &  exe_op1_sel[0];
assign op1_data = ({32{op1_sel_rs1}} & exe_rs1_data) |
                  ({32{op1_sel_pc }} & exe_pc) |
                  ({32{op1_sel_imm}} & exe_imm);

// op2_data: CSR读优先，否则rs2/imm二选一
wire op2_sel_csr = |exe_csr_cmd;
wire op2_sel_rs2 = ~op2_sel_csr &  exe_op2_sel[1];
wire op2_sel_imm = ~op2_sel_csr &  exe_op2_sel[0];
assign op2_data = ({32{op2_sel_csr}} & csr_rdata) |
                  ({32{op2_sel_rs2}} & exe_rs2_data) |
                  ({32{op2_sel_imm}} & exe_imm);

// ALU计算结果 - 优化关键路径
wire [31:0] alu_add;            // 加法 - 关键路径
wire [31:0] alu_addi;           // 加法（有符号） - 关键路径
wire [31:0] alu_sub;            // 减法 - 关键路径
wire [31:0] alu_and;            // 按位与 - 快速路径
wire [31:0] alu_or;             // 按位或 - 快速路径
wire [31:0] alu_xor;            // 按位异或 - 快速路径
wire [31:0] alu_sll;            // 逻辑左移
wire [31:0] alu_srl;            // 逻辑右移
wire [31:0] alu_sra;            // 算术右移
wire [31:0] alu_slt;            // 有符号比较小于
wire [31:0] alu_sltu;           // 无符号比较小于
wire [31:0] alu_jalr;           // JALR指令的ALU操作
wire [31:0] alu_copy1;          // 仅将第一个操作数传递

// 关键路径加法 - 共享单一加法结果（ADD/ADDI/JALR复用）
wire [31:0] alu_add_common = op1_data + op2_data;
assign alu_add = alu_add_common;
assign alu_addi = alu_add_common;
assign alu_sub = op1_data - op2_data;

// 快速逻辑运算 - 并行计算
assign alu_and = op1_data & op2_data;
assign alu_or  = op1_data | op2_data;
assign alu_xor = op1_data ^ op2_data;

// 其他运算
assign alu_sll = op1_data << op2_data[4:0];
assign alu_srl = op1_data >> op2_data[4:0];
assign alu_sra = ({{32{op1_data[31]}}, op1_data} >> op2_data[4:0]);
assign alu_slt = ($signed(op1_data) < $signed(op2_data)) ? 32'd1 : 32'd0;
assign alu_sltu = (op1_data < op2_data) ? 32'd1 : 32'd0;
assign alu_jalr = alu_add_common & ~32'd1;
assign alu_copy1 = csr_rdata;
wire [31:0] alu_csrrc = op2_data & ~op1_data; 

// ALU操作类型解码
wire ALU_ADD, ALU_ADDI, ALU_SUB, ALU_AND, ALU_OR, ALU_XOR;
wire ALU_SLL, ALU_SRL, ALU_SRA, ALU_SLT, ALU_SLTU;
wire ALU_JALR, ALU_COPY1;
assign {ALU_ADD, ALU_ADDI, ALU_SUB, ALU_AND, ALU_OR, ALU_XOR,
        ALU_SLL, ALU_SRL, ALU_SRA, ALU_SLT, ALU_SLTU,
        ALU_JALR, ALU_COPY1} = exe_alu_op;

// 分支比较结果 - 直接使用原始数据,避免锁存延迟
wire alu_beq = (exe_rs1_data == exe_rs2_data) ? 1'b1 : 1'b0;
wire alu_blt = ($signed(exe_rs1_data) < $signed(exe_rs2_data)) ? 1'b1 : 1'b0;
wire alu_bltu = (exe_rs1_data < exe_rs2_data) ? 1'b1 : 1'b0;

// ALU结果选择 - 并行掩码合并，替代长优先级链
wire [31:0] alu_result;
wire [31:0] alu_result_addsub = ({32{ALU_ADD }} & alu_add ) |
                                ({32{ALU_ADDI}} & alu_addi) |
                                ({32{ALU_SUB }} & alu_sub );
wire [31:0] alu_result_logic  = ({32{ALU_AND }} & alu_and ) |
                                ({32{ALU_OR  }} & alu_or  ) |
                                ({32{ALU_XOR }} & alu_xor );
wire [31:0] alu_result_shift  = ({32{ALU_SLL }} & alu_sll ) |
                                ({32{ALU_SRL }} & alu_srl ) |
                                ({32{ALU_SRA }} & alu_sra );
wire [31:0] alu_result_misc   = ({32{ALU_SLT  }} & alu_slt  ) |
                                ({32{ALU_SLTU }} & alu_sltu ) |
                                ({32{ALU_JALR }} & alu_jalr ) |
                                ({32{ALU_COPY1}} & alu_copy1);
assign alu_result = alu_result_addsub | alu_result_logic | alu_result_shift | alu_result_misc;

// 分支比较结果 - 并行解码
wire br_beq  = (exe_br_type == 3'b001);
wire br_bne  = (exe_br_type == 3'b010);
wire br_blt  = (exe_br_type == 3'b011);
wire br_bge  = (exe_br_type == 3'b100);
wire br_bltu = (exe_br_type == 3'b101);
wire br_bgeu = (exe_br_type == 3'b110);
wire br_flag = (br_beq  &  alu_beq ) |
               (br_bne  & ~alu_beq ) |
               (br_blt  &  alu_blt ) |
               (br_bge  & ~alu_blt ) |
               (br_bltu &  alu_bltu) |
               (br_bgeu & ~alu_bltu);
assign br_taken = exe_jmp_flag || (|exe_br_type && br_flag);
assign br_target = exe_jmp_flag ? alu_jalr : alu_result;

// 访存专用通路：地址/写使能/写数据完全独立于ALU结果选择链
wire [31:0] mem_addr_calc = exe_rs1_data + exe_imm;
wire exe_mem_size_0 = exe_mem_size[0];
wire exe_mem_size_1 = exe_mem_size[1];
wire mem_size_word = ~exe_mem_size_0 & ~exe_mem_size_1;
wire mem_size_half =  exe_mem_size_0 & ~exe_mem_size_1;
wire mem_size_byte =  exe_mem_size_0 &  exe_mem_size_1;

wire exe_mem_addr_bit1 = mem_addr_calc[1];
wire exe_mem_addr_bit0 = mem_addr_calc[0];
wire [1:0] exe_mem_addr_bits = mem_addr_calc[1:0];

// 写使能：按访存宽度one-hot解码后并行组合
wire [3:0] data_sram_wen_32bit = 4'b1111;
wire [3:0] data_sram_wen_16bit = exe_mem_addr_bit1 ? 4'b1100 : 4'b0011;
wire [3:0] data_sram_wen_8bit = 4'b0001 << exe_mem_addr_bits;
wire [3:0] data_sram_wen_uncoded = ({4{mem_size_word}} & data_sram_wen_32bit) |
                                   ({4{mem_size_half}} & data_sram_wen_16bit) |
                                   ({4{mem_size_byte}} & data_sram_wen_8bit);

// 写数据：按访存宽度并行展开，避免级联选择链
wire [31:0] data_sram_wdata_32bit = exe_rs2_data;
wire [31:0] data_sram_wdata_16bit = {exe_rs2_data[15:0], exe_rs2_data[15:0]};
wire [31:0] data_sram_wdata_8bit = {exe_rs2_data[7:0], exe_rs2_data[7:0], exe_rs2_data[7:0], exe_rs2_data[7:0]};

assign data_sram_en = exe_mem_re;
assign data_sram_addr = mem_addr_calc;
assign data_sram_wen = (exe_mem_we && es_allowin) ? data_sram_wen_uncoded : 4'b0000;
assign data_sram_wdata = ({32{mem_size_word}} & data_sram_wdata_32bit) |
                         ({32{mem_size_half}} & data_sram_wdata_16bit) |
                         ({32{mem_size_byte}} & data_sram_wdata_8bit);

wire [4:0] exe_to_mem_size;
assign exe_to_mem_size = {exe_mem_addr_bits, exe_mem_size};

//数据前递
assign exe_id_data = alu_result;
assign exe_id_waddr = exe_rd_addr;
assign exe_id_we = exe_rd_wen;

// csr写数据 - 并行命令解码
wire csr_cmd_csrrw  = (exe_csr_cmd == 4'b0001);
wire csr_cmd_csrrs  = (exe_csr_cmd == 4'b0010);
wire csr_cmd_csrrc  = (exe_csr_cmd == 4'b0011);
wire csr_cmd_csrrwi = (exe_csr_cmd == 4'b0101);
wire csr_cmd_csrrsi = (exe_csr_cmd == 4'b0110);
wire csr_cmd_csrrci = (exe_csr_cmd == 4'b0111);
wire [31:0] exe_csr_wdata = ({32{csr_cmd_csrrw  | csr_cmd_csrrwi}} & op1_data) |
                            ({32{csr_cmd_csrrs  | csr_cmd_csrrsi}} & alu_or) |
                            ({32{csr_cmd_csrrc  | csr_cmd_csrrci}} & alu_csrrc);
assign exe_id_csr_wdata = exe_csr_wdata;
assign exe_id_csr_we = exe_csr_we;
assign exe_id_csr_addr = exe_csr_addr;

// 输出到访存阶段的总线打包
assign exe_mem_bus_out = {
    exe_to_mem_size, // [4:0] 送往访存阶段的访存大小和地址偏移信息
    exe_pc,         // [31:0] 当前指令地址
    alu_result,     // [31:0] ALU计算结果
    exe_rd_addr,    // [4:0] 目的寄存器地址
    exe_rd_wen,     // 1-bit 目的寄存器写使能
    exe_wb_sel,     // [2:0] 写回数据选择信号
    exe_csr_we,     // 1-bit CSR写使能
    exe_csr_addr,   // [11:0] CSR地址
    exe_csr_wdata   // [31:0] CSR写数据
};

// 输出异常相关信号
wire exception_iam = br_taken && (br_target[1:0] != 2'b00); // 判断分支跳转目标地址是否为非4字节对齐
wire exception_lam = ((!exe_mem_size[0] && exe_mem_addr_bits != 2'b00 && exe_mem_re) ||
                    (exe_mem_size[0] && !exe_mem_size[1] && exe_mem_addr_bit0 != 1'b0 && exe_mem_re)); // 32位访存时，地址必须为4字节对齐;16位访存时，地址必须为2字节对齐
wire exception_sam = (exe_mem_we && !exe_mem_size[0] && exe_mem_addr_bits != 2'b00) || (exe_mem_we && exe_mem_size[0] && !exe_mem_size[1] && exe_mem_addr_bit0 != 1'b0); // 8位访存时，地址必须为4字节对齐;16位访存时，地址必须为2字节对齐
assign exception_code_em = exception_iam ? 6'b100000 :
                           exception_lam ? 6'b100100 :
                           exception_sam ? 6'b100110 :
                           exception_code_reg; 
assign exception_mtval_em = exception_iam ? br_target : 
                            (exception_lam || exception_sam) ? mem_addr_calc :
                            exception_mtval_reg;

endmodule