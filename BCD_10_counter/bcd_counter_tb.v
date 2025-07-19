`timescale 1ns/1ns 
`include "bcd_counter.v"

module bcd_counter_tb;
    
wire [3:0] out;
reg clk, rst;

bcd_counter uut (.clk(clk), .rst(rst), .out(out));

initial begin
    $dumpfile("bcd_counter.vcd");
    $dumpvars(0, bcd_counter_tb);

    clk = 0;
    rst = 1'b1; 
    

    $monitor("Time: %0t || clk: %0b || rst: %0b || count: %04b", $time, clk, rst, out); 

    #8 rst = 0;
    
    #100 $finish;
end
    
always #5 clk = ~clk;

endmodule
