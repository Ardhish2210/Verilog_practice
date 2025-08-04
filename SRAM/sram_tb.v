`timescale 1ns/1ns
`include "sram.v"

module sram_tb; 

reg clk;
reg w_enable; 
reg [7:0] addr, data_in;
wire [7:0] data_out;

sram uut (clk, w_enable, addr, data_in, data_out);

initial begin 
    $dumpfile("sram.vcd");
    $dumpvars(0, sram_tb);

    $monitor("Time: %0t || clk: %0b || data_in: %07b || w_enable: %0b || data_out: %07b || addr: %07b", $time, clk, data_in, w_enable, data_out, addr);

    clk = 0;
    w_enable = 0;
    addr = 7'b0000000;
    data_in = 7'b0000000;

    #10  w_enable = 0; addr = 7'b0000001; data_in = 7'b1111111;
    #10  w_enable = 1; 
    #10  w_enable = 0; addr = 7'b0000010; data_in = 7'b1111000;
    #10  w_enable = 1;

    #10 $finish;
end
always #5 clk = ~clk;

endmodule