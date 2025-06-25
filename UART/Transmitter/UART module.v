module uart_tx (
    input wire clk,
    input wire rst,
    input wire send,
    input wire [7:0] data,
    output reg tx,
    output reg busy
);

 
    reg [12:0] baud_cnt = 0;
    reg [3:0] bit_index = 0;
    reg [7:0] tx_data;
    reg [1:0] state = 0; // 0=IDLE, 1=START, 2=DATA, 3=STOP

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            tx <= 1'b1;
            busy <= 0;
            baud_cnt <= 0;
            bit_index <= 0;
            state <= 0;
        end else begin
            case (state)
                0: begin // IDLE
                    tx <= 1'b1;
                    busy <= 0;
                    if (send) begin
                        tx_data <= data;
                        state <= 1;
                        busy <= 1;
                        baud_cnt <= 0;
                    end
                end

                1: begin // START bit
                    tx <= 1'b0;
                    if (baud_cnt < 5207)
                        baud_cnt <= baud_cnt + 1;
                    else begin
                        baud_cnt <= 0;
                        state <= 2;
                        bit_index <= 0;
                    end
                end

                2: begin // DATA bits
                    tx <= tx_data[bit_index];
                    if (baud_cnt < 5207)
                        baud_cnt <= baud_cnt + 1;
                    else begin
                        baud_cnt <= 0;
                        bit_index <= bit_index + 1;
                        if (bit_index == 7)
                            state <= 3;
                    end
                end

                3: begin // STOP bit
                    tx <= 1'b1;
                    if (baud_cnt < 5207)
                        baud_cnt <= baud_cnt + 1;
                    else begin
                        baud_cnt <= 0;
                        state <= 0;
                        busy <= 0;
                    end
                end
            endcase
        end
    end
endmodule

