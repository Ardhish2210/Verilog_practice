module carry_save_adder (A, B, C, SUM, COUT);

input [3:0] A, B, C;
output [3:0] SUM
output COUT;

full_adder F1 (.a(A[0]), .b(B[0]), .cin(C[0]), .sum(SUM[0]), .cout(COUT[0]));
full_adder F2 (.a(), .b(), .cin(), .sum(), .cout());
full_adder F3 (.a(), .b(), .cin(), .sum(), .cout());
full_adder F4 (.a(), .b(), .cin(), .sum(), .cout());
    
endmodule   