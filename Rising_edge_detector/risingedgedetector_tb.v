`timescale 1ns/1ns
`include "risingedgedetector.v"

module risingedgedetector_tb;

reg clk, rst, d;
wire out;

risingedgedetector uut (clk, d, rst, out);

always #5 clk = ~clk;

initial begin
    $dumpfile("risingedgedetector.vcd");
    $dumpvars(0, risingedgedetector_tb);

    clk = 0;
    rst = 1; 
    d = 0;

    $monitor ("Time: %0t || clk: %0d || rst: %0b || d: %0b || out: %0b", $time, clk, rst, d, out);

    #8 rst = 0;
    #3 d = 1;
    #10 d = 0;
    #10 d = 0;
    #10 d = 1;

    #10 $finish;

end
endmodule