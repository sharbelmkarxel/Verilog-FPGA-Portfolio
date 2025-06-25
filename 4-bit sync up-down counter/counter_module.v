module counter_module(
    input wire clk,
    input wire rst,
    input wire en,
    input wire sel,
    input wire trigger,
    output reg zero_flag,
    output reg max_flag,
    output reg[3:0] count
);

always @(posedge clk) begin
    if(rst) begin
    count<=4'b0000;
    zero_flag <= 1'b1;
    end
    else if(en&&trigger) begin
        case(sel)
        1'b0: count <=count +1;
        1'b1: count <= count -1;
        endcase
        zero_flag <= (count == 4'b0000);
        max_flag <= (count == 4'b1111);
    end 
end


endmodule
