`timescale 1ns/1ns
`include "four_bit_counter.v"

module four_bit_counter_tb;

reg clk, clr, ld;
reg [3:0] in;
wire [3:0] out;

four_bit_counter uut (clk, clr, ld, in, out);

initial begin 
    $dumpfile("four_bit_counter.vcd");
    $dumpvars(0, four_bit_counter_tb);

    clk = 0;
    in = 4'b1010;

    $monitor("time: %0t || clk: %0d || ld: %0b || clr: %0b || in: %04b || out: %04b", $time, clk, ld, clr, in, out);

    #3 ld = 1; clr = 0;
    #10 ld = 0;
    #10 in = 4'b1111; 
    #10 clr = 1;
    #10 clr = 0;
    #10 ld = 1;

    #30 $finish;
end

always #5 clk = ~clk;

endmodule
