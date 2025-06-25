
`timescale 1ms/1ms


module fifo_tb();



reg clk;
reg rst;
reg [7:0] data_in;
reg write_enable;  
reg read_enable;
wire [7:0] data_out;
wire full; 
wire empty;


// Instantiate the FIFO module
fifo_module #(
    .WIDTH(8),
    .DEPTH(16),
    .ADDR_WIDTH(4)
) fifo_inst (
    .clk(clk),
    .rst(rst),
    .data_in(data_in),
    .write_enable(write_enable),
    .read_enable(read_enable),
    .data_out(data_out),
    .full(full),
    .empty(empty)
);
always #5 clk = ~clk; // Clock generation

initial begin
    clk = 0;
    rst = 1;
    data_in = 8'h00;
    write_enable = 0;
    read_enable = 0;

    // Reset the FIFO
    #10 rst = 0;

    // Write data into FIFO
    #10 data_in = 8'hA1; write_enable = 1; 
    #10 write_enable = 0;

    #10 data_in = 8'hB2; write_enable = 1; 
    #10 write_enable = 0;

    // Read data from FIFO
    #10 read_enable = 1; 
    #10 read_enable = 0;

    // Check if FIFO is empty
    #10 if (empty) $display("FIFO is empty");

    // Write more data
    #10 data_in = 8'hC3; write_enable = 1; 
    #10 write_enable = 0;

    // Read again
    #10 read_enable = 1; 
    #10 read_enable = 0;

    // Check full condition
    #10 if (full) $display("FIFO is full");

    // Finish simulation
    #50 $finish;
end

endmodule
