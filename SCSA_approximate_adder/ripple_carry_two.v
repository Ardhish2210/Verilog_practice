module ripple_carry_two (a, b, cin, sum, cout);

input [1:0] a, b;
input cin;
output cout;
output [1:0] sum;
wire c1;

full_adder f1 (.a(a[0]), .b(b[0]), .cin(cin), .sum(sum[0]), .cout(c1));
full_adder f2 (.a(a[1]), .b(b[1]), .cin(c1), .sum(sum[1]), .cout(cout));

endmodule