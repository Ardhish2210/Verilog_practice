module carry_save_adder_tb; 

reg [3:0] A, B, C;
wire [3:0] SUM, COUT;

carry_save_adder uut (A, B, C, SUM, COUT);

initial begin
  $dumpfile("carry_save_adder.vcd");
  $dumpvars(0, carry_save_adder_tb);

end
endmodule