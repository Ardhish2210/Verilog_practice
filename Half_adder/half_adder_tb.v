`timescale 1ns/1ns
`include "half_adder.v"

module half_adder_tb; 

reg a, b;
wire sum, cout;

half_adder uut (a, b, sum, cout);

initial begin
  $dumpfile("half_adder.vcd");
  $dumpvars(0, half_adder_tb);

  $monitor("a: %0b || b: %0b || sum: %0b || cout: %0b", a, b, sum, cout);

  a = 0; b = 0; 

  #10 a = 0; b = 0;
  #10 a = 0; b = 1; 
  #10 a = 1; b = 0; 
  #10 a = 1; b = 1;  

  #10 $finish;
end
endmodule