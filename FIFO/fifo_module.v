module fifo_module #(
    parameter WIDTH = 8,
    parameter DEPTH = 16,
    parameter ADDR_WIDTH = 4
) (
    input clk,
    input rst,
    input [WIDTH-1:0] data_in,
    input write_enable,
    input read_enable,
    output reg [WIDTH-1:0] data_out,
    output wire full,
    output wire empty

);


reg [WIDTH-1:0] fifo_mem [0:DEPTH-1];

reg [ADDR_WIDTH-1:0] write_ptr;
reg [ADDR_WIDTH-1:0] read_ptr;
reg[ADDR_WIDTH:0] count;

always @(posedge clk ) begin
    if(rst) begin
        write_ptr <=0;
    end
    else if (write_enable && !full) begin
        fifo_mem[write_ptr]<=data_in;
        write_ptr <= write_ptr +1;
    end
    
end

always @(posedge clk) begin
    if(rst) begin
        read_ptr <=0;
    end
    else if (read_enable && !empty) begin
        data_out <= fifo_mem[read_ptr];
        read_ptr <= read_ptr +1;
    end
end

always @(posedge clk ) begin
    if(rst) begin 
        count<=0;
    end
    else begin
        case({write_enable && !full, read_enable && !empty})
        2'b10: count <= count+1;
        2'b01: count <= count-1;
        default: count <= count;
        endcase
    end



end



assign full = (count == DEPTH);
assign empty = (count == 0);

endmodule