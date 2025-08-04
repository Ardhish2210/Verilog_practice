module carry_save_adder_tb; 

reg [3:0] A, B, C;
wire [3:0] SUM, COUT;

carry_save_adder uut (A, B, C, SUM, COUT);
endmodule