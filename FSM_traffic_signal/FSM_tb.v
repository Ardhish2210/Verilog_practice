`timescale 1ps/1ps
`include "FSM.v"

module FSM_tb; 

reg clk;
wire [2:0] light;

FSM uut (clk, light);


always #5 clk = ~clk;
initial begin
    clk = 1'b0;
    #100 $finish;
end

initial begin
    $monitor("Time: %t | RGY: %b", $time, light);
end
endmodule