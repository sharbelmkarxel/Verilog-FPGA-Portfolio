module single_port_memory_module #(
    parameter width = 32,
    parameter depth = 8)
    (
        input wire clk,
        input wire we,
        input [$clog2(depth)-1:0] addr,
        input [width-1:0] data_in,
        output reg [width-1:0] data_out
    );

    reg [width-1:0] ram[depth-1:0];
    always@(posedge clk) begin
        if(we) begin
            ram[addr] <=data_in;
        end
        else begin
            data_out <= ram[addr];
        end
    end
endmodule

