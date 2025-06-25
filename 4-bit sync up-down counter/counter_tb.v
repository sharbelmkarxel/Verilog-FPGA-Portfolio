`timescale 1ns / 1ps

module counter_module_tb;

    // DUT Inputs
    reg clk;
    reg rst;
    reg en;
    reg sel;
    reg trigger;

    // DUT Outputs
    wire zero_flag;
    wire max_flag;
    wire [3:0] count;

    // Instantiate the DUT
    counter_module uut (
        .clk(clk),
        .rst(rst),
        .en(en),
        .sel(sel),
        .trigger(trigger),
        .zero_flag(zero_flag),
        .max_flag(max_flag),
        .count(count)
    );

    // Clock generator: 10ns period
    always #5 clk = ~clk;

    // Stimulus
    initial begin
        // Initialize signals
        clk = 0;
        rst = 1;
        en = 0;
        sel = 0;
        trigger = 0;

        #10;
        rst = 0;        // Deassert reset
        en = 1;
        trigger = 1;

        // Count UP from 0 to 15
        sel = 0;
        repeat(16) @(posedge clk);

        // Count DOWN from 15 to 0
        sel = 1;
        repeat(16) @(posedge clk);

        // Disable enable and observe no change
        en = 0;
        repeat(4) @(posedge clk);

        // Reset again to see flags reset
        rst = 1;
        @(posedge clk);
        rst = 0;

        #20;
        $stop;
    end

endmodule
