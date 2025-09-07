`include "sr_latch.v"

module sr_latch_tb;

reg s, r, clk, rst;
wire q;

sr_latch uut (s, r, clk, rst, q);

initial begin
    $dumpfile("sr_latch.vcd");
    $dumpvars(0, sr_latch_tb);

    $monitor("Time: %0t || clk: %d || rst: %b || s: %b || r: %b || q: %b", $time, clk, rst, s, r, q);

    clk = 0;
    rst = 1;
    s = 0;
    r = 0;

    #8 rst = 0;

    #5 s = 0; r = 0;
    #10 s = 0; r = 1;
    #10 s = 1; r = 0;
    #10 s = 1; r = 1;

    #10 $finish;
end

always #5 clk = ~clk;

endmodule