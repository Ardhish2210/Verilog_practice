`timescale 1ns/1ns
`include "ama2.v"

module ama2_tb; 

reg a, b, cin;
wire sum, cout;

ama2 uut (a, b, cin, sum, cout);

initial begin
    $dumpfile("ama2.vcd");
    $dumpvars(0, ama2_tb);

    $monitor("a: %0b || b: %0b || cin: %0b || sum: %0b || cout: %0b", a, b, cin, sum, cout);

    a = 0; b = 0; cin = 0;

    #10 a = 0; b = 0; cin = 0;
    #10 a = 1; b = 0; cin = 1;
    #10 a = 1; b = 1; cin = 0;
    #10 a = 0; b = 1; cin = 1;

    #10 $finish;
end
    
endmodule