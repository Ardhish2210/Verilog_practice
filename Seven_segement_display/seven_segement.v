module seven_segement (clk, rst, bin_in, dp_en, blink_in, blink_rate, seg, dp, en);

input clk, rst,  dp_en, blink_in;
input [3:0] bin_in;
input [23:0] blink_rate;
output reg seg [6:0]; // MSB- A, LSB- G
output dp;
output en; 

always @(posedge clk or negedge rst) begin
    if (rst) begin
        seg <= 7'b1111111;
        dp <= 1'b1;
        en <= 1'b0
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
    end else if (blink_en == 1'b1) begin

    end
end
    
endmodule