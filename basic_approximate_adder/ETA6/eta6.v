`include "full_adder.v"

module eta6 (A, B, SUM, COUT);

input [5:0] A, B;
output [5:0] SUM;
output COUT;
// for bits 0 to 2, no carry is considered, carry is only considered from 3 to 6 bits
wire sum_0, sum_1, sum_2, sum_3, sum_4, sum_5;
wire carry_3, carry_4, carry_5;

assign sum_0 = A[0] ^ B[0];   
assign sum_1 = A[1] ^ B[1];
assign sum_2 = A[2] ^ B[2]; 

full_adder F1 (.a(A[3]), .b(B[3]), .cin(1'b0), .sum(sum_3), .cout(carry_3));
full_adder F2 (.a(A[4]), .b(B[4]), .cin(carry_3), .sum(sum_4), .cout(carry_4));
full_adder F3 (.a(A[5]), .b(B[5]), .cin(carry_4), .sum(sum_5), .cout(carry_5));

assign SUM = {sum_5, sum_4, sum_3, sum_2, sum_1, sum_0};
assign COUT = carry_5;

endmodule