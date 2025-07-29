`timescale 1ns/1ns
`include "counter_ten.v"

module counter_ten_tb; 

reg clk, rst;
wire [3:0] counter;

counter_ten uut (clk, rst, counter);

initial begin 
    $dumpfile("counter_ten.vcd");
    $dumpvars(0, counter_ten_tb);

    $monitor("Time: %0t || clk: %0b || rst: %0b || counter: %0b", $time, clk, rst, counter);

    clk = 0;
    rst = 1;

    #3 rst = 0;
    #40 rst = 1;

    #10 $finish;

end
endmodule