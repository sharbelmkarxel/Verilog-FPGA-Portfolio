module dual_port_ram #(
    parameter width = 32,
    parameter depth = 256

)
(
    input wire clk,
    input wire we_a,we_b,
    input [$clog2(depth)-1:0] addr_a, addr_b,
    input wire [width-1:0] data_in_a, data_in_b,
    output reg [width-1:0] data_out_a,data_out_b

)

reg [width-1:0] dp_ram[depth-1:0];

always @(posedge clk) begin

    if((we_a && we_b) & (addr_a == addr_b)) begin
        dp_ram[addr_b]<= data_in_a;
        end
        
    if(we_a) begin
       dp_ram[addr_a]<=data_in_a; 
       
    end
    else begin
        data_out_a <= dp_ram[addr_a];
    end

    if(we_b) begin
       dp_ram[addr_b]<=data_in_b; 
       
    end
    else begin
        data_out_b <= dp_ram[addr_b];
    end
end



endmodule
    
        