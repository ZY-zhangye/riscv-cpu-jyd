`timescale 1ns/1ps
module tb_top;
    reg w_clk_50Mhz;
    reg w_clk_rst;
    reg i_uart_rx;
    wire o_uart_tx;
    reg clk_cnt;
    wire [31:0] virtual_led;
    wire [39:0] virtual_seg;

    top top_inst(
        .w_clk_50Mhz(w_clk_50Mhz),
        .clk_cnt(clk_cnt),
        .w_clk_rst(w_clk_rst),
        .i_uart_rx(i_uart_rx),
        .o_uart_tx(o_uart_tx),
        .virtual_led(virtual_led),
        .virtual_seg(virtual_seg)
    );

    initial begin
        w_clk_50Mhz = 0;
        clk_cnt = 0;
        w_clk_rst = 0;
        i_uart_rx = 1; // UART idle state is high
        #100; // Hold reset for 100 time units
        w_clk_rst = 1; // Release reset
    end
    always #5 w_clk_50Mhz = ~w_clk_50Mhz; // 50MHz clock
    always #10 clk_cnt = ~clk_cnt; // Clock count signal
    initial begin
        $monitor("Time: %0t | Virtual LED: %h", $time, virtual_led);
    end
    initial begin
        if (virtual_led !== 32'h0000_0000 && virtual_led !== 32'hxxxx_XXXX) begin
            $display("LED changed: %h", virtual_led);
            #1000; // Wait for some time to observe changes
            $finish; // End simulation
        end
    end
    initial begin 
        #1000000000; // Timeout after 1 second of simulation time
        $display("Simulation timed out.");
        $finish;
    end
endmodule