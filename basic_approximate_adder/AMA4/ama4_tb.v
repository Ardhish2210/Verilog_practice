`timescale 1ns/1ns
`include "ama4.v"

module ama4_tb; 

reg a, b, cin;
wire sum, cout;

ama4 uut (a, b, cin, sum, cout);

initial begin
    $dumpfile("ama4.vcd");
    $dumpvars(0, ama4_tb);

    $monitor("time: %0t || a: %0b || b: %0b || cin: %0b || sum: %0b || cout: %0b", $time, a, b, cin, sum, cout);

    a = 1'b0;
    b = 1'b0;
    cin = 1'b0;

    #3 a = 0; b = 0; cin = 1;
    #10 a = 0; b = 1; cin = 0;
    #10 a = 1; b = 0; cin = 1;
    #10 a = 1; b = 1; cin = 0;

    #10 $finish;
end
    
endmodule