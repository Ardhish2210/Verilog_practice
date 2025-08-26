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
    #10 rst = 0;

    #5 in_pulse = 1;
    #5 in_pulse = 0;
    #5 in_pulse = 1;

    #100 $finish;

end

endmodule