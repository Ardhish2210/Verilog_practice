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
    w_enable = 1;
    addr = 8'b00000000;
    data_in = 8'b10101010;
    
    #10 w_enable = 1; addr = 8'b00000001; data_in = 8'b11001100;  
    #10 w_enable = 1; addr = 8'b00000010; data_in = 8'b11110000;
    #10 w_enable = 0;addr = 8'b00000000;  
    #10 addr = 8'b00000001;  
    #10 addr = 8'b00000010;

    #10 $finish;
end

always #5 clk = ~clk;

endmodule