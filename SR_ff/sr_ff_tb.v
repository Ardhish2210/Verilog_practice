`include "sr_ff.v"

module sr_ff_tb;

reg s, r, clk, rst;
wire q;

sr_ff uut (s, r, clk, rst, q);

initial begin

    $dumpfile("sr_ff.vcd");
    $dumpvars(0, sr_ff_tb);

    $monitor("Time: %t || clk: %b || rst: %0t || s: %b || r: %b || q: %b", $time, clk, rst, s, r, q);

    clk = 0; rst = 1; s = 0; r = 0; 

    #5 rst = 0;

    #10 s = 0; r = 0; 
    #10 s = 0; r = 1; 
    #10 s = 1; r = 0; 
    #10 s = 1; r = 1; 

    #10 $finish;
end

always #5 clk = ~clk;

endmodule