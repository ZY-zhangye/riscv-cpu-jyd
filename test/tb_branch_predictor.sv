`timescale 1ns/1ps

// tb_branch_predictor.sv
// Test scope:
// 1) Reset clear for GHR, PHT, BTB
// 2) Decode path for OTHER, BRANCH, JAL, JALR
// 3) BTB hit, miss, and alias-with-tag-mismatch
// 4) Full 2-bit PHT state transitions
// 5) Output behavior for PHT/BTB combinations
// 6) branch_result_valid gating behavior
// 7) GHR shift-update behavior
// 8) Random stimulus with shadow-model checking

module tb_branch_predictor;

    localparam int GHR_WIDTH = 8;
    localparam int PHT_SIZE  = 256;
    localparam int BTB_SIZE  = 256;
    localparam int RAND_ITERS = 600;

    logic         clk;
    logic         rst_n;
    logic [31:0]  pc_in;
    logic [31:0]  inst_in;
    logic         branch_result_valid;
    logic [31:0]  branch_pc;
    logic         branch_taken;
    logic [31:0]  branch_target;
    logic         predict_valid;
    logic         predict_taken;
    logic [31:0]  predict_target;

    int error_count;

    // Opcodes used by this test
    localparam logic [31:0] INST_OTHER = 32'h0000_0013;
    localparam logic [31:0] INST_BEQ   = 32'h0000_0063;
    localparam logic [31:0] INST_JAL   = 32'h0000_006F;
    localparam logic [31:0] INST_JALR  = 32'h0000_0067;

    // Shadow model state
    logic [GHR_WIDTH-1:0] model_ghr;
    logic [1:0]           model_pht [0:PHT_SIZE-1];
    logic [31:0]          model_btb_tag [0:BTB_SIZE-1];
    logic [31:0]          model_btb_target [0:BTB_SIZE-1];
    logic                 model_btb_valid [0:BTB_SIZE-1];

    branch_predictor #(
        .GHR_WIDTH(GHR_WIDTH),
        .PHT_SIZE(PHT_SIZE),
        .BTB_SIZE(BTB_SIZE)
    ) dut (
        .clk(clk),
        .rst_n(rst_n),
        .pc_in(pc_in),
        .inst_in(inst_in),
        .branch_result_valid(branch_result_valid),
        .branch_pc(branch_pc),
        .branch_taken(branch_taken),
        .branch_target(branch_target),
        .predict_valid(predict_valid),
        .predict_taken(predict_taken),
        .predict_target(predict_target)
    );

    always #5 clk = ~clk;

    task automatic expect_eq(bit cond, string msg);
        begin
            if (!cond) begin
                error_count++;
                $display("[FAIL] %s @ t=%0t", msg, $time);
            end else begin
                $display("[PASS] %s", msg);
            end
        end
    endtask

    task automatic drive_if(input logic [31:0] pc, input logic [31:0] inst);
        begin
            pc_in   = pc;
            inst_in = inst;
            #1;
        end
    endtask

    task automatic do_feedback(
        input logic [31:0] pc,
        input logic        taken,
        input logic [31:0] target,
        input logic        valid
    );
        begin
            branch_pc           = pc;
            branch_taken        = taken;
            branch_target       = target;
            branch_result_valid = valid;
            @(posedge clk);
            #1;
            branch_result_valid = 1'b0;
        end
    endtask

    task automatic expect_prediction(
        input logic exp_valid,
        input logic exp_taken,
        input logic [31:0] exp_target,
        input string msg
    );
        begin
            expect_eq(predict_valid === exp_valid, {msg, " | predict_valid mismatch"});
            expect_eq(predict_taken === exp_taken, {msg, " | predict_taken mismatch"});
            expect_eq(predict_target === exp_target, {msg, " | predict_target mismatch"});
        end
    endtask

    function automatic bit is_branch_inst(input logic [31:0] inst);
        is_branch_inst = (inst[6:0] == 7'b1100011);
    endfunction

    function automatic bit is_jump_inst(input logic [31:0] inst);
        is_jump_inst = (inst[6:0] == 7'b1101111) || (inst[6:0] == 7'b1100111);
    endfunction

    function automatic logic [1:0] pht_next_state(input logic [1:0] cur, input logic taken);
        case (cur)
            2'b00: pht_next_state = taken ? 2'b01 : 2'b00;
            2'b01: pht_next_state = taken ? 2'b10 : 2'b00;
            2'b10: pht_next_state = taken ? 2'b11 : 2'b01;
            2'b11: pht_next_state = taken ? 2'b11 : 2'b10;
            default: pht_next_state = 2'b00;
        endcase
    endfunction

    task automatic model_reset;
        int k;
        begin
            model_ghr = '0;
            for (k = 0; k < PHT_SIZE; k++) begin
                model_pht[k] = 2'b00;
            end
            for (k = 0; k < BTB_SIZE; k++) begin
                model_btb_valid[k]  = 1'b0;
                model_btb_tag[k]    = '0;
                model_btb_target[k] = '0;
            end
        end
    endtask

    task automatic model_predict(
        input  logic [31:0] pc,
        input  logic [31:0] inst,
        output logic        exp_valid,
        output logic        exp_taken,
        output logic [31:0] exp_target
    );
        int pht_index;
        int btb_index;
        logic [1:0] pht_state;
        logic btb_hit;
        logic branch_type;
        logic jump_type;
        begin
            pht_index = ((pc >> 2) & ((1 << GHR_WIDTH) - 1)) ^ model_ghr;
            btb_index = ((pc >> 2) & ((1 << GHR_WIDTH) - 1));
            pht_state = model_pht[pht_index];
            btb_hit   = model_btb_valid[btb_index] && (model_btb_tag[btb_index] == pc);

            branch_type = is_branch_inst(inst);
            jump_type   = is_jump_inst(inst);

            exp_valid  = branch_type || jump_type;
            exp_taken  = 1'b0;
            exp_target = 32'h0;

            if (exp_valid) begin
                exp_taken = pht_state[1];
                if (jump_type) begin
                    exp_taken  = 1'b1;
                    exp_target = btb_hit ? model_btb_target[btb_index] : (pc + 32'd4);
                end else begin
                    exp_target = (exp_taken && btb_hit) ? model_btb_target[btb_index] : (pc + 32'd4);
                end
            end
        end
    endtask

    task automatic model_update(
        input logic [31:0] pc,
        input logic taken,
        input logic [31:0] target,
        input logic valid
    );
        int pht_index;
        int btb_index;
        begin
            if (valid) begin
                pht_index = ((pc >> 2) & ((1 << GHR_WIDTH) - 1)) ^ model_ghr;
                btb_index = ((pc >> 2) & ((1 << GHR_WIDTH) - 1));

                model_pht[pht_index] = pht_next_state(model_pht[pht_index], taken);
                model_btb_tag[btb_index] = pc;
                model_btb_target[btb_index] = target;
                model_btb_valid[btb_index] = 1'b1;

                model_ghr = {model_ghr[GHR_WIDTH-2:0], taken};
            end
        end
    endtask

    task automatic check_pht_transition(
        input logic [1:0] init_state,
        input logic       taken,
        input logic [1:0] exp_state,
        input string      msg
    );
        logic [31:0] pc_t;
        int idx;
        begin
            pc_t = 32'h0000_0040;
            idx  = pc_t[GHR_WIDTH+1:2];

            dut.ghr      = '0;
            dut.pht[idx] = init_state;

            do_feedback(pc_t, taken, 32'h0000_0200, 1'b1);
            expect_eq(dut.pht[idx] === exp_state, msg);
        end
    endtask

    integer i;
    logic [31:0] pc_btb;
    logic [31:0] pc_alias;
    logic [31:0] tgt_btb;
    int btb_idx;
    int pht_idx;
    int rand_sel;

    logic [31:0] r_pc;
    logic [31:0] r_inst;
    logic        r_fb_valid;
    logic [31:0] r_fb_pc;
    logic        r_fb_taken;
    logic [31:0] r_fb_target;

    logic        exp_v;
    logic        exp_t;
    logic [31:0] exp_tar;

    initial begin
        clk                 = 1'b0;
        rst_n               = 1'b0;
        pc_in               = '0;
        inst_in             = INST_OTHER;
        branch_result_valid = 1'b0;
        branch_pc           = '0;
        branch_taken        = 1'b0;
        branch_target       = '0;
        error_count         = 0;

        // deterministic tests
        repeat (2) @(posedge clk);
        #1;
        rst_n = 1'b1;
        #1;

        expect_eq(dut.ghr === '0, "reset clears GHR");
        expect_eq(dut.pht[0] === 2'b00, "reset clears PHT[0]");
        expect_eq(dut.pht[255] === 2'b00, "reset clears PHT[255]");
        expect_eq(dut.btb_valid[0] === 1'b0, "reset clears BTB valid[0]");
        expect_eq(dut.btb_valid[255] === 1'b0, "reset clears BTB valid[255]");

        drive_if(32'h0000_0100, INST_OTHER);
        expect_prediction(1'b0, 1'b0, 32'h0000_0000, "other instruction behavior");

        drive_if(32'h0000_0104, INST_BEQ);
        expect_prediction(1'b1, 1'b0, 32'h0000_0108, "branch default behavior");

        drive_if(32'h0000_0108, INST_JAL);
        expect_prediction(1'b1, 1'b1, 32'h0000_010C, "jal default behavior on btb miss");

        drive_if(32'h0000_010C, INST_JALR);
        expect_prediction(1'b1, 1'b1, 32'h0000_0110, "jalr default behavior on btb miss");

        pc_btb  = 32'h0000_0120;
        tgt_btb = 32'h0000_0888;
        do_feedback(pc_btb, 1'b1, tgt_btb, 1'b1);

        drive_if(pc_btb, INST_JAL);
        expect_prediction(1'b1, 1'b1, tgt_btb, "btb hit returns stored target");

        pc_alias = pc_btb + 32'h0000_0400;
        drive_if(pc_alias, INST_JAL);
        expect_prediction(1'b1, 1'b1, pc_alias + 32'd4, "btb alias with tag mismatch is miss");

        check_pht_transition(2'b00, 1'b0, 2'b00, "PHT 00 + NT -> 00");
        check_pht_transition(2'b00, 1'b1, 2'b01, "PHT 00 + T  -> 01");
        check_pht_transition(2'b01, 1'b0, 2'b00, "PHT 01 + NT -> 00");
        check_pht_transition(2'b01, 1'b1, 2'b10, "PHT 01 + T  -> 10");
        check_pht_transition(2'b10, 1'b0, 2'b01, "PHT 10 + NT -> 01");
        check_pht_transition(2'b10, 1'b1, 2'b11, "PHT 10 + T  -> 11");
        check_pht_transition(2'b11, 1'b0, 2'b10, "PHT 11 + NT -> 10");
        check_pht_transition(2'b11, 1'b1, 2'b11, "PHT 11 + T  -> 11");

        dut.ghr = '0;
        pht_idx = (32'h0000_0200 >> 2) & ((1 << GHR_WIDTH) - 1);
        btb_idx = (32'h0000_0200 >> 2) & ((1 << GHR_WIDTH) - 1);

        dut.pht[pht_idx]        = 2'b10;
        dut.btb_valid[btb_idx]  = 1'b1;
        dut.btb_tag[btb_idx]    = 32'h0000_0200;
        dut.btb_target[btb_idx] = 32'h0000_0A00;

        drive_if(32'h0000_0200, INST_BEQ);
        expect_prediction(1'b1, 1'b1, 32'h0000_0A00, "branch PHT taken plus BTB hit");

        dut.btb_valid[btb_idx] = 1'b0;
        drive_if(32'h0000_0200, INST_BEQ);
        expect_prediction(1'b1, 1'b1, 32'h0000_0204, "branch PHT taken plus BTB miss");

        dut.pht[pht_idx]       = 2'b01;
        dut.btb_valid[btb_idx] = 1'b1;
        drive_if(32'h0000_0200, INST_BEQ);
        expect_prediction(1'b1, 1'b0, 32'h0000_0204, "branch PHT not taken");

        dut.ghr = 8'hA5;
        dut.btb_valid[btb_idx] = 1'b0;
        branch_pc     = 32'h0000_0300;
        branch_taken  = 1'b1;
        branch_target = 32'h0000_0555;

        do_feedback(branch_pc, branch_taken, branch_target, 1'b0);
        expect_eq(dut.ghr === 8'hA5, "valid gate blocks GHR update");
        expect_eq(dut.btb_valid[branch_pc[GHR_WIDTH+1:2]] === 1'b0, "valid gate blocks BTB update");

        dut.ghr = 8'b1010_1010;
        do_feedback(32'h0000_0340, 1'b1, 32'h0000_0600, 1'b1);
        expect_eq(dut.ghr === 8'b0101_0101, "GHR shift update with taken=1");
        do_feedback(32'h0000_0344, 1'b0, 32'h0000_0604, 1'b1);
        expect_eq(dut.ghr === 8'b1010_1010, "GHR shift update with taken=0");

        // Random test phase: reset DUT and model to same initial state.
        rst_n = 1'b0;
        repeat (2) @(posedge clk);
        #1;
        rst_n = 1'b1;
        #1;
        model_reset();

        // deterministic seed for reproducibility
        void'($urandom(32'h1A2B_3C4D));

        for (i = 0; i < RAND_ITERS; i++) begin
            rand_sel = $urandom_range(0, 99);

            // Generate instruction type
            case ($urandom_range(0, 3))
                0: r_inst = INST_OTHER;
                1: r_inst = INST_BEQ;
                2: r_inst = INST_JAL;
                default: r_inst = INST_JALR;
            endcase

            // Generate aligned fetch PC. Sometimes force alias pattern.
            r_pc = ($urandom() & 32'h000F_FFFC);
            if (rand_sel < 20) begin
                r_pc = (r_pc & 32'h0000_03FC) | 32'h0000_1000;
            end

            model_predict(r_pc, r_inst, exp_v, exp_t, exp_tar);
            drive_if(r_pc, r_inst);
            expect_prediction(exp_v, exp_t, exp_tar, $sformatf("random predict check iter=%0d", i));

            // Feedback generation
            r_fb_valid  = ($urandom_range(0, 99) < 80);
            r_fb_taken  = $urandom_range(0, 1);
            r_fb_target = ($urandom() & 32'h000F_FFFC);

            // Sometimes update using current fetch PC to increase BTB hit chances.
            if ($urandom_range(0, 99) < 60) begin
                r_fb_pc = r_pc;
            end else begin
                r_fb_pc = ($urandom() & 32'h000F_FFFC);
            end

            do_feedback(r_fb_pc, r_fb_taken, r_fb_target, r_fb_valid);
            model_update(r_fb_pc, r_fb_taken, r_fb_target, r_fb_valid);
        end

        $display("==============================================");
        if (error_count == 0) begin
            $display("ALL TESTS PASSED");
        end else begin
            $display("TEST FAILED, error_count = %0d", error_count);
        end
        $display("==============================================");

        if (error_count == 0) begin
            $finish;
        end else begin
            $fatal(1, "tb_branch_predictor failed");
        end
    end

endmodule
