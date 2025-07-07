`timescale 1ns/1ns
`include "johnson_counter.v"

module johnson_counter_tb;

    reg clk = 0, rst = 1;
    wire [3:0] q;

    johnson_counter uut (.clk(clk), .rst(rst), .q(q));

    always #5 clk = ~clk;

    initial begin
        $dumpfile("johnson_counter.vcd");
        $dumpvars(0, johnson_counter_tb);

        #10 rst = 0;
        #85 $finish;
    end

    initial begin
        $monitor("Time: %0t | q: %b", $time, q);
    end
endmodule
