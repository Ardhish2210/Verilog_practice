`timescale 1ns/1ns
`include "t_ff.v"

module t_ff_tb;

reg t, clk, rst;
wire q;

t_ff uut (t, clk, rst, q);

initial begin
    $dumpfile("t_ff.vcd");
    $dumpvars(0, t_ff_tb);

    $monitor("time: %0t || clk: %0b || rst: %0b || t: %0b || q: %0b", $time, clk, rst, t, q);

    clk = 0; rst = 1; t = 0;
    #10 rst = 0;

    #10 t = 1; 
    #10 t = 1;  
    
    #10 $finish;
end

always #5 clk = ~clk;

endmodule