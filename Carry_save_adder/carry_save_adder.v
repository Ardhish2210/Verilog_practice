`include "full_adder.v"

module carry_save_adder (A, B, C, SUM, COUT);

input [3:0] A, B, C;
output [3:0] SUM, COUT;

full_adder F1 (.a(A[0]), .b(B[0]), .cin(C[0]), .sum(SUM[0]), .cout(COUT[0]));
full_adder F2 (.a(A[1]), .b(B[1]), .cin(C[1]), .sum(SUM[1]), .cout(COUT[1]));
full_adder F3 (.a(A[2]), .b(B[2]), .cin(C[2]), .sum(SUM[2]), .cout(COUT[2]));
full_adder F4 (.a(A[3]), .b(B[3]), .cin(C[3]), .sum(SUM[3]), .cout(COUT[3]));

    
endmodule   