`timescale 1ns/1ns
`include "sequence_dct.v"

module sequence_dct_tb;

reg clk, rst, in;
wire out;

sequence_dct uut (clk, rst, in, out);

initial begin
    $dumpfile("sequence_dct.vcd");
    $dumpvars();

    $monitor("Time: %0t || clk: %0b || rst: %0b || in: %0b || out: %0b", 
             $time, clk, rst, in, out);

    clk = 0;
    rst = 1;
    in = 0;
    #8 rst = 0;

    // -------- Test Vector 1: Exact 0111 --------
    #4  in = 1'b0;   // 0
    #10 in = 1'b1;   // 01
    #10 in = 1'b1;   // 011
    #10 in = 1'b1;   // 0111 --> should detect here

    // -------- Test Vector 2: Extra 1's after match (overlapping) --------
    #10 in = 1'b1;   // Another 1 — check overlap or reset

    // -------- Test Vector 3: Random noise before valid sequence --------
    #10 in = 1'b1;
    #10 in = 1'b0;   // Restart
    #10 in = 1'b1;
    #10 in = 1'b1;
    #10 in = 1'b1;   // Should detect again

    // -------- Test Vector 4: Incomplete match --------
    #10 in = 1'b0;
    #10 in = 1'b1;
    #10 in = 1'b0;   // Broken sequence, no detection

    // -------- Test Vector 5: Multiple sequences --------
    #10 in = 1'b0;
    #10 in = 1'b1;
    #10 in = 1'b1;
    #10 in = 1'b1;   // 0111 → detect
    #10 in = 1'b0;
    #10 in = 1'b1;
    #10 in = 1'b1;
    #10 in = 1'b1;   // 0111 again → detect

    #20 $finish;
end

always #5 clk = ~clk;

endmodule
