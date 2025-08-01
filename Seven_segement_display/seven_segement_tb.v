module seven_segement_tb;

reg clk, rst,  dp_en, blink_in;
reg [3:0] bin_in;
reg [23:0] blink_rate;
wire [6:0] seg ; // MSB- A, LSB- G
wire dp;
wire en;

seven_segement uut (clk, rst, bin_in, dp_en, blink_in, blink_rate, seg, dp, en);

initial begin
    $dumpfile("seven_segement.vcd");
    $dumpvars(0, seven_segement_tb);

    $monitor("Time: %0t || clk: %0b || rst: %0b || bin_in: %04b || dp_en: %0b || blink_en: %0b || seg: %07b || dp: %0b || en: %0b", $time, clk, rst, bin_in, dp_en, blink_en, seg, dp, en);
end
endmodule 
