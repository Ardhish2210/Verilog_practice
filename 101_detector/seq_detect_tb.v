`timescale 1ns/1ns
`include "seq_detect.v"

module seq_detect_tb;

reg clk, rst, in;
wire out;

seq_detect uut (clk, rst, in, out);

initial begin
    $dumpfile("seq_detect.vcd");
    $dumpvars(0, seq_detect_tb);

    $monitor("Time: %0t || clk: %0b || rst: %0b || in: %0b || out: %0b", $time, clk, rst, in, out);

    clk = 0;
    rst = 1;
    in = 0;
    #8 rst = 0;

    #4  in = 1'b1;
    #10 in = 1'b0;
    #10 in = 1'b1;

    #10 in = 1'b0;
    #10 in = 1'b0;
    #10 in = 1'b0;

    #10 in = 1'b1;
    #10 in = 1'b1;
    #10 in = 1'b0;
    #10 in = 1'b1;

    #10 in = 1'b1;
    #10 in = 1'b1;
    #10 in = 1'b1;
    #10 in = 1'b1;

    #10 in = 1'b1;
    #10 in = 1'b0;
    #10 in = 1'b1;
    #10 in = 1'b1;
    #10 in = 1'b0;
    #10 in = 1'b1;

    #10 $finish;
end

always #5 clk = ~clk;

endmodule
