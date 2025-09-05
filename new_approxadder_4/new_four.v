module new_adder (a, b, sum);

input [31:0] a, b;
output [32:0] sum;
wire cmsp;

assign sum[14:0] = a[14:0] | b[14:0];
assign cmsp = a[15] & b[15];
assign sum[15] = (cmsp) ? 0 : a[15]|b[15];


endmodule