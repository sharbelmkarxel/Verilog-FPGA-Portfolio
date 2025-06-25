module ALU_module#(
    parameter word_length)
    (
        input [word_length-1:0] A,
        input [word_length-1:0] B,
        input reg[1:0] ALU_control,
        output reg [word_length:0] C,
        output wire zero_flag
        


    );


always@(A,B,ALU_control)begin
    case(ALU_control)
        2'b00: C = A+B;
        2'b01: C = A-B;
        2'b10: C = A&B;
        2'b11: C = A | B;
    endcase
end

assign zero_flag = (C ==0)? 1'b1 : 1'b0;

endmodule



