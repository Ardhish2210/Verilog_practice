module carry_save_adder_tb; 

reg [3:0] A, B, C;
wire [3:0] SUM, COUT;

carry_save_adder uut (A, B, C, SUM, COUT);

initial begin
  $dumpfile("carry_save_adder.vcd");
  $dumpvars(0, carry_save_adder_tb);

  $monitor("Time: %0t || A: %04b || B: %04b || C: %04b || SUM: %04b || COUT: %04b", $time, A, B, C, SUM, COUT);

  A = 4'b0000; B = 4'b0000; C = 4'b0000;
  #10 A = 4'b0000; B = 4'b0000; C = 4'b0000;
  #10 A = 4'b0101; B = 4'b0011; C = 4'b0110;
  #10 A = 4'b0010; B = 4'b1100; C = 4'b1010;

  #10 $finish;
end
endmodule