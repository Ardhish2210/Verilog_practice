`timescale 1ns/1ns
`include "d_ff.v"

module d_ff_tb;

    reg clk, d, rst;
    wire q;

    d_ff uut (.q(q), .clk(clk), .d(d), .rst(rst));

    always #5 clk = ~clk;

    initial begin
        $dumpfile("d_ff.vcd");
        $dumpvars(0, d_ff_tb);

        $monitor("time: %4t || clk: %b || d: %b || rst: %b || q: %b", $time, clk, d, rst, q);

        clk = 0;
        rst = 1;  
        d = 0;

        #8  rst = 0;  
        #5  d = 1;    
        #10 d = 0;    
        #10 d = 1;   
        #10 d = 0;    

        #10 $finish;
    end

endmodule
