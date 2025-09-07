`timescale 1ms/1us
`include "clock.v"

module clock_tb;

reg clk, rst;
wire hours, minutes, seconds;

clock uut (clk, rst, hours, minutes, seconds);

initial begin

    $dumpfile("clock.vcd");
    $dumpvars(0, clock_tb);

    $monitor ("Time: %t || clk: %b || rst: %b || HOURS: %b || MINUTES: %b || SECONDS: %b", $time, clk, rst, hours, minutes, seconds);

    clk = 0; rst = 1;
    #0.1 rst = 0;
end

always #0.1 clk = ~clk;

endmodule