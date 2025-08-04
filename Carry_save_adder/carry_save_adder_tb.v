module carry_save_adder_tb; 

reg [3:0] A, B, C;
wire [3:0] SUM, COUT;

carry_save_adder uut (A, B, C, SUM, COUT);

initial begin
  $dumpfile("carry_save_adder.vcd");
  $dumpvars(0, carry_save_adder_tb);

  $monitor("Time: %0t || A: %04b || B: %04b || C: %04b || SUM: %04b || COUT: %04b", $time, A, B, C, SUM, COUT);

end
endmodule