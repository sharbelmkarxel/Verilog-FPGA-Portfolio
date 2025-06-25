module full_adder(
    input reg [0:3] a,
    input reg [0:3] b,
    input c_in,
    output reg [0:3 ] sum,
    output c_out );

    wire c1,c2,c3;

    half_adder(a[3],b[3],c_in, sum[3], c1);
    half_adder(a[2],b[2],c1, sum[3], c2);
    half_adder(a[1],b[1],c2, sum[3], c3);
    half_adder(a[0],b[0],c3, sum[3], c_out);

endmodule

