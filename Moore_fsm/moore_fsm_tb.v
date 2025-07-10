`timescale 1ns/1ns
`include "moore_fsm.v"

module moore_fsm_tb;

    reg clk, rst, in;
    wire out;

    moore_fsm fsm (.clk(clk), .rst(rst), .in(in), .out(out));

    always #5 clk = ~clk;

    initial begin

        $dumpfile("moore_fsm.vcd");
        $dumpvars(0, moore_fsm_tb);
        
        $monitor("Time: %0t || rst: %0b || in: %0b || out: %0b", $time, rst, in, out);

        clk = 0; 
        rst = 1; in = 0;  
        #10 rst = 0;               

        #10 in = 0;                
        #10 in = 1;                
        #20 in = 0;                
        #10 rst = 1;               
        #10 rst = 0; in = 0;       

        #10 $finish;               
    end

endmodule
