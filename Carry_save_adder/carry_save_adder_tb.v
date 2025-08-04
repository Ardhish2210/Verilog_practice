`timescale 1ns/1ns
`include "carry_save_adder.v"

module carry_save_adder_tb; 

reg [3:0] A, B, C;
wire [3:0] SUM, COUT;
wire [4:0] final_sum;

carry_save_adder uut (A, B, C, SUM, COUT, final_sum);

initial begin
  $dumpfile("carry_save_adder.vcd");
  $dumpvars(0, carry_save_adder_tb);

  $monitor("A: %b || B: %b || C: %b || SUM: %b || COUT: %b || final_sum: %05b", A, B, C, SUM, COUT, final_sum);

  A = 4'b0000; B = 4'b0000; C = 4'b0000;
  #10 A = 4'b0000; B = 4'b0000; C = 4'b0000;
  #10 A = 4'b0101; B = 4'b0011; C = 4'b0110;
  #10 A = 4'b0010; B = 4'b1100; C = 4'b1010;

  #10 $finish;
end
endmodule