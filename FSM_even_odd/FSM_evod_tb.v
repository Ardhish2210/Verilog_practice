`timescale 1ps/1ps
`include "FSM_evod.v"

module FSM_evod_tb;

    reg x, clk;        
    wire z;            

    FSM_evod uut (.x(x), .clk(clk), .z(z));

    initial begin
        $dumpfile("FSM_evod.vcd"); 
        $dumpvars(0, FSM_evod_tb);

        $monitor("Time = %t || x = %b || z = %b", $time, x, z);

        clk = 1'b0;
        x = 1'b0; 

        #2  x = 0; #10 x = 1; #10 x = 1; #10 x = 1;
        #10 x = 0; #10 x = 1; #10 x = 1; #10 x = 0;
        #10 x = 0; #10 x = 1; #10 x = 1; #10 x = 0;
        #10 $finish;
    end

    always #5 clk = ~clk;

endmodule
