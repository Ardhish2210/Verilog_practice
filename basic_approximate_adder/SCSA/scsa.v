`include "full_adder.v"

module scsa (a, b, sum, cout);

input [3:0] a, b;
output [3:0] sum;
output cout;

wire c_1, c_2;
wire [2:0] lsb_sum;
wire lsb_carry;

// the LSB's are added directly without any carry_in (approx)
assign lsb_sum = a[1:0] + b[1:0];
assign sum[1:0] = lsb_sum[1:0];
assign lsb_carry = lsb_sum [2];

full_adder F1 (.a(a[2]), .b(b[2]), .cin(lsb_carry), .sum(sum[2]), .cout(c_1));
full_adder F2 (.a(a[3]), .b(b[3]), .cin(c_1), .sum(sum[3]), .cout(c_2));

assign cout = c_2;

endmodule