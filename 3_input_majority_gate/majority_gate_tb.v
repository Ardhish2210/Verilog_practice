`timescale 1ns/1ns
`include "majority_gate.v"

module majority_gate_tb;

reg a, b, c;
wire out;
integer i;

majority_gate uut (a, b, c, out);

initial begin
  $dumpfile("majority_gate.vcd");
  $dumpvars(0, majority_gate_tb);

  $monitor("a: %0b || b: %0b || c: %0b || out: %0b", a, b, c, out);

  for (i = 0; i < 8; i = i + 1) begin
    {a,b,c} = i;
    #10;
  end
end
    
endmodule