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

    $monitor("Time: %0t || clk: %0b || rst: %0b || bin_in: %04b || dp_en: %0b || blink_in: %0b || seg: %07b || dp: %0b || en: %0b", $time, clk, rst, bin_in, dp_en, blink_in, seg, dp, en);

    clk = 0;
    rst = 1;
    dp_en = 0;
    blink_in = 0;
    bin_in = 4'b0000;
    blink_rate = 24'd10;

    #8 rst = 0;

    // Show digit 2 without blink or dp
    #3 bin_in = 4'b0010;

    // Enable decimal point
    #10 dp_en = 1;

    // Enable blink
    #10 blink_in = 1;

    // Change digit to 5
    #30 bin_in = 4'b0101;

    // Change blink rate
    #50 blink_rate = 24'd5;

    // Disable blink and decimal
    #50 blink_in = 0;
    dp_en = 0;

    // Final digit test
    #20 bin_in = 4'b1001;

    // Finish simulation
    #50 $finish;
end

always #5 clk = ~clk;

endmodule
