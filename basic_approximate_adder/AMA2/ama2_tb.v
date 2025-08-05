`timescale 1ns/1ns
`include "ama2.v"

module ama2_tb; 

reg a, b, cin;
wire sum, cout;

ama2 uut (a, b, cin, sum, cout);

initial begin
    $dumpfile("ama2.vcd");
    $dumpvars(0, ama2_tb);

    
end
    
endmodule