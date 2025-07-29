`timescale 1ns/1ns
`include "counter_ten.v"

module counter_ten_tb; 

reg clk, rst;
wire [3:0] counter;

counter_ten uut (clk, rst, counter);

initial begin 
    $dumpfile("counter_ten.vcd");
    $dumpvars(0, counter_ten_tb.v);
    
end
endmodule