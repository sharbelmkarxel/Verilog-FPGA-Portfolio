`timescale 1ms/1ns

module ALU_testbench();



reg [7:0] A;
reg [7:0] B;
reg [1:0] ALU_control;
wire [8:0] C;
wire zero_flag;


ALU_module #(.word_length(8)) uut(
    .A(A),
    .B(B),
    .ALU_control(ALU_control),
    .C(C),
    .zero_flag(zero_flag)
);

initial begin
A = 8'b00001101;
B = 8'b00001000;
ALU_control = 2'b00;
#3;

 // Test addition


ALU_control = 2'b10;
A = 8'b00001101;
B = 8'b00001000;
#3;

end


endmodule
