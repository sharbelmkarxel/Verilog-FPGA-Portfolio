`timescale 1ns/1ps

module sram_tb;

reg clk;
reg we;
reg [2:0] addr;
reg [31:0] data_in;
wire [31:0] data_out;

single_port_memory_module #(
    .width(32),
    .depth(8)
) uut (
    .clk(clk),
    .we(we),
    .addr(addr),
    .data_in(data_in),
    .data_out(data_out)
);

// Clock generation
always #5 clk = ~clk;

initial begin
    // Initialize inputs
    clk = 0;
    we = 0;
    addr = 0;
    data_in = 0;

    // Test writing to memory
    #10;
    we = 1; // Enable write
    addr = 3; // Address to write to
    data_in = 32'hA5A5A5A5; // Data to write
    #10; // Wait for a clock cycle

    // Test reading from memory
    we = 0; // Disable write
    addr = 3; // Address to read from
    #10; // Wait for a clock cycle

    // Check output
    if (data_out !== 32'hA5A5A5A5) begin
        $display("Test failed: Expected %h, got %h", 32'hA5A5A5A5, data_out);
    end else begin
        $display("Test passed: Read %h from address %d", data_out, addr);
    end

    $finish;
end
endmodule