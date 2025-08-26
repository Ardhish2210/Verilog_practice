`timescale 1ns/1ns
`include "pulse.v"

module pulse_tb;

reg clk, rst, in_pulse;
wire out_pulse;

pulse uut (clk, rst, in_pulse, out_pulse);

initial begin
    $dumpfile("pulse.vcd");
    $dumpvars(0, pulse_tb);

    $monitor("Time: %0t || clk: %b || rst: %b || in_pulse: %b || out_pulse: %b", $time, clk, rst, in_pulse, out_pulse);

    clk = 0;
    in_pulse = 0;
    rst = 1;
    #12 rst = 0;

    #10 in_pulse = 1;
    #10 in_pulse = 0;

    #100;

    #20 in_pulse = 1;
    #10 in_pulse = 0;

    #100 $finish;

end

always #5 clk = ~clk;

endmodule