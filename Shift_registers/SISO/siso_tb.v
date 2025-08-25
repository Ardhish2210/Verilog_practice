`timescale 1ns/1ns
`include "siso.v"

module siso_tb;

reg clk, rst, sin;
wire sout;

siso uut (clk, rst, sin, sout);

initial begin
    $dumpfile("siso.vcd");
    $dumpvars(0, siso_tb);

    $monitor("Time: %0t || clk: %b || rst: %b || sin: %b || sout: %b", $time, clk, rst, sin, sout);

    clk = 0;
    rst = 1;
    sin = 0;
    #10 rst = 0; 

        sin = 1; #10;
        sin = 0; #10;
        sin = 1; #10;
        sin = 1; #10;

        #50 $finish;
end

always #5 clk = ~clk;

endmodule