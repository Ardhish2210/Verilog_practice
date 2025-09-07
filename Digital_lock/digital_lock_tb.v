`timescale 1ns/1ps
`include "digital_lock.v"

module digital_lock_tb;

reg clk, rst;
reg in_seq;
wire out;

digital_lock uut (clk, rst, in_seq, out);

initial begin

    $dumpfile("digital_lock.vcd");
    $dumpvars(0, digital_lock_tb);

    $monitor("Time: %t || clk: %b || rst: %b || in_seq: %b || out = %b", $time, clk, rst, in_seq, out);

    clk = 0; rst = 1; in_seq = 1'b0; 

    #5 rst = 0;

    #10 in_seq = 1'b1;
    #10 in_seq = 1'b1;
    #10 in_seq = 1'b0;
    #10 in_seq = 1'b1;
    
    #20 $finish;
end

always #5 clk = ~clk; 

endmodule