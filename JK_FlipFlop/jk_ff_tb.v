`timescale 1ns/1ns
`include "jk_ff.v"

module jk_ff_tb;

reg j, k, clk, rst;
wire q;

jk_ff uut (j, k, clk, rst, q);

initial begin
    $dumpfile("jk_ff.vcd");
    $dumpvars(0, jk_ff_tb);

    $monitor("time: %0t || clk: %0b || rst: %0b || j: %0b || k: %0b || q: %0b", $time, clk, rst, j, k, q);

    clk = 0; rst = 1;
    #10 rst = 0;

    #10 j = 0; k = 0;
    #10 j = 0; k = 1;
    #10 j = 1; k = 0;
    #10 j = 1; k = 1;
    
    #10 $finish;
end

always #5 clk = ~clk;

endmodule