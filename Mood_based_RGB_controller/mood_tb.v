`timescale 1ns/1ns
`include "mood.v"

module mood_tb; 

reg [1:0] brain_wave;
reg clk, rst;
wire [2:0] rgb;
wire blink;

mood uut (brain_wave, clk, rst, rgb, blink);

initial begin
    $dumpfile("mood.vcd");
    $dumpvars(0, mood_tb);

    $monitor("Time: %0t || rst: %0b || brain_wave: %02b || rgb: %03b || blink: %0b", $time, rst, brain_wave, rgb, blink);

    clk = 0;
    rst = 1;
    brain_wave = 0;

    #5 rst = 0;
    #8 brain_wave = 2'b00;
    #10 brain_wave = 2'b00;
    #10 brain_wave = 2'b01;
    #10 brain_wave = 2'b10;
    #10 brain_wave = 2'b11;

    #10 $finish;
end

always #5 clk = ~clk;
    
endmodule