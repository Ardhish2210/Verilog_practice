`timescale 1ns/1ns
`include "full_subtractor.v"

module full_subtractor_tb; 

reg A, B, b_in;
wire diff, b_out;

full_subtractor uut (A, B, b_in, diff, b_out);

initial begin
  $dumpfile("full_subtractor.vcd");
  $dumpvars(0, full_subtractor_tb);

  $monitor("a: %0b || b: %0b || b_in: %0b || difference: %0b || b_out: %0b", A, B, b_in, diff, b_out);

  A = 0; B = 0; b_in = 0;

  #10 A = 0; B = 0; b_in = 0;
  #10 A = 0; B = 0; b_in = 1;
  #10 A = 0; B = 1; b_in = 0;
  #10 A = 0; B = 1; b_in = 1;
  #10 A = 1; B = 0; b_in = 0;
  #10 A = 1; B = 1; b_in = 1;

  #10 $finish;
end
endmodule