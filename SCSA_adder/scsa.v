module scsa (a, b, sum, cout);

input [7:0] a, b;
output [7:0] sum;
output cout;

// n = no. of bits used in approx adder, k = The size of each sub-adder used, // m = n/k (number of sub adder used)
// In this SCSA approximate adder we are using n = 8bit and k=2bit, hence m = 4 sub-adders will be used

wire c0, c1_0, c1_1;
wire [1:0] sum_mux_1;
// CODE for BLOCK0
ripple_carry_two B0 (.a(a[1:0]), .b(b[1:0]), .cin(1'b0), .sum(sum[1:0]), .cout(c0));

//CODE for BLOCK1
ripple_carry_two B1_0 (.a(a[3:2]), .b(b[3:2]), .cin(1'b0), .sum(sum[3:2]), .cout(c1_0));
ripple_carry_two B1_1 (.a(a[3:2]), .b(b[3:2]), .cin(1'b1), .sum(sum[3:2]), .cout(c1_1));

assign sum_mux_1 = (c0) ? B1_1.(sum[3:2]) : B1_0.(sum[3:2]);
    
endmodule