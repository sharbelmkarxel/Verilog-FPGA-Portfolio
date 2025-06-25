module complete_adder_tb();

reg [0:3] a,b,c_in;
output sum,c_out;

complete_adder(
    .a(a),
    .b(b),
    .c_in(c_in),
    .sum(sum),
    .c_out(c_out)
    );
initial begin
        a = 0; b = 0; c_in = 0; #10;
    a = 0; b = 1; c_in = 0; #10;
    a = 1; b = 0; c_in = 0; #10;
    a = 1; b = 1; c_in = 0; #10;
    a = 0; b = 0; c_in = 1; #10;
    a = 0; b = 1; c_in = 1; #10;
    a = 1; b = 0; c_in = 1; #10;
    a = 1; b = 1; c_in = 1; #10;
end
endmodule
