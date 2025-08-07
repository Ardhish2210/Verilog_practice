`timescale 1ns/1ns
`include "half_subtractor.v"

module half_subtractor_tb; 

reg a, b;
output diff, borrow;

half_subtractor uut (a, b, diff, borrow);

initial begin
  $dumpfile("half_subtractor.vcd");
  $dumpvars(0, half_subtractor_tb);

  $monitor("a: %0b || b: %0b || difference: %0b || borrow: %0b", a, b, diff, borrow);

  a = 0; b = 0; 

  #10 a = 0; b = 1; 
  #10 a = 1; b = 0; 
  #10 a = 1; b = 1;  

  #10 $finish;
end

endmodule