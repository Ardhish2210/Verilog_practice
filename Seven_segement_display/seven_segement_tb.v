module seven_segement_tb;

reg clk, rst,  dp_en, blink_in;
reg [3:0] bin_in;
reg [23:0] blink_rate;
wire [6:0] seg ; // MSB- A, LSB- G
wire dp;
wire en;

seven_segement uut (clk, rst, bin_in, dp_en, blink_in, blink_rate, seg, dp, en);

initial begin
end
endmodule 