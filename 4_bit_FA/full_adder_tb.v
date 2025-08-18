`timescale 1ns/1ns
`include "full_adder.v"

module full_adder_tb;

reg a, b, cin;
wire sum, cout;

full_adder uut (a, b, cin, sum, cout);

endmodule