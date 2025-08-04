`include "full_adder.v"

module carry_save_adder (A, B, C, SUM, COUT, final_sum);

input [3:0] A, B, C;
wire [3:0] sum_temp, cout_temp;
output [4:0] final_sum;
output [3:0] SUM, COUT;

full_adder F1 (.a(A[0]), .b(B[0]), .cin(C[0]), .sum(sum_temp[0]), .cout(cout_temp[0]));
full_adder F2 (.a(A[1]), .b(B[1]), .cin(C[1]), .sum(sum_temp[1]), .cout(cout_temp[1]));
full_adder F3 (.a(A[2]), .b(B[2]), .cin(C[2]), .sum(sum_temp[2]), .cout(cout_temp[2]));
full_adder F4 (.a(A[3]), .b(B[3]), .cin(C[3]), .sum(sum_temp[3]), .cout(cout_temp[3]));

assign SUM = sum_temp;
assign COUT = cout_temp;

assign final_sum = {1'b0, SUM} + (COUT<<1);
    
endmodule   