module seven_segement (clk, rst, bin_in, dp_en, blink_in, blink_rate, seg, dp, en);

input clk, rst,  dp_en, blink_in;
input [3:0] bin_in;
input [23:0] blink_rate;
output reg [6:0] seg ; // MSB- A, LSB- G
output reg dp;
output reg en; 

reg [23:0] blink_counter = 0;
reg blink_state = 1'b1;

always @(posedge clk or posedge rst) begin
    if (rst) begin
        seg <= 7'b1111111;
        dp <= 1'b1;
        en <= 1'b0;
    end

    case (bin_in)
    4'b0000: seg <= 7'b1111110;
    4'b0001: seg <= 7'b0110000;
    4'b0010: seg <= 7'b1101101;
    4'b0011: seg <= 7'b1111001;
    4'b0100: seg <= 7'b0110011;
    4'b0101: seg <= 7'b1011011;
    4'b0110: seg <= 7'b1011111;
    4'b0111: seg <= 7'b1110000;
    4'b1000: seg <= 7'b1111111;
    4'b1001: seg <= 7'b1111011;
    endcase

    if (dp_en == 1'b1) begin
        dp = 1'b0;
    end 

    if (blink_in == 1'b1) begin
        if (blink_counter >= blink_rate) begin
            blink_counter <= 0;
            blink_state <= ~blink_state;
        end else begin
            blink_counter <= blink_counter + 1;
        end
        en <= blink_state;
    end else begin
        en <= 1'b1;  // always ON if blinking is disabled
    end
end
    
endmodule


