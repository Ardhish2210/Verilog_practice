module scsa (a, b, sum, cout);

input [7:0] a, b;
output [7:0] sum;
output cout;

// n = no. of bits used in approx adder, k = The size of each sub-adder used, // m = n/k (number of sub adder used)
// In this SCSA approximate adder we are using n = 8bit and k=2bit, hence m = 4 sub-adders will be used

wire c1_0, c1_1, c2_0, c2_1, c3_0, c3_1;
wire c0, c1, c2;
wire [1:0] sum1_0, sum1_1, sum2_0, sum2_1, sum3_0, sum3_1;

// CODE for BLOCK0
ripple_carry_two B0 (.a(a[1:0]), .b(b[1:0]), .cin(1'b0), .sum(sum[1:0]), .cout(c0));

//CODE for BLOCK1
ripple_carry_two B1_0 (.a(a[3:2]), .b(b[3:2]), .cin(1'b0), .sum(sum1_0), .cout(c1_0));
ripple_carry_two B1_1 (.a(a[3:2]), .b(b[3:2]), .cin(1'b1), .sum(sum1_1), .cout(c1_1));

assign sum[3:2] = (c0) ? sum1_1:sum1_0;
assign c1 = (c0) ? c1_1:c1_0;

//CODE for BLOCK2
ripple_carry_two B2_0 (.a(a[5:4]), .b(b[5:4]), .cin(1'b0), .sum(sum2_0), .cout(c2_0));
ripple_carry_two B2_1 (.a(a[5:4]), .b(b[5:4]), .cin(1'b1), .sum(sum2_1), .cout(c2_1));

assign sum[5:4] = (c1) ? sum2_1:sum2_0;
assign c2 = (c1) ? c2_1:c2_0;

//CODE for BLOCK3
ripple_carry_two B3_0 (.a(a[7:6]), .b(b[7:6]), .cin(1'b0), .sum(sum3_0), .cout(c3_0));
ripple_carry_two B3_1 (.a(a[7:6]), .b(b[7:6]), .cin(1'b1), .sum(sum3_1), .cout(c3_1));

assign sum[7:6] = (c2) ? sum3_1:sum3_0;
assign cout = (c2) ? c3_1:c3_0;

endmodule