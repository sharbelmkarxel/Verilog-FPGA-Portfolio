`timescale 1us/1ns   // Time unit = 1us, precision = 1ns

module uart_tx_tb;

    reg clk;
    reg rst;
    reg send;
    reg [7:0] data;
    wire tx;
    wire busy;

    // Instantiate UART Transmitter
    uart_tx uut (
        .clk(clk),
        .rst(rst),
        .send(send),
        .data(data),
        .tx(tx),
        .busy(busy)
    );

    // Generate clock: 100 ns period (10 MHz)
    always #0.05 clk = ~clk;  // 50 ns half period = 100 ns full period

    initial begin
        clk = 0;
        rst = 1;
        send = 0;
        data = 8'b10101010;

        
        #5;
        rst = 0;

       
        #20;
        send = 1;
        #0.1;       
        send = 0;

       
        #2000;     

        $finish;
    end

endmodule
