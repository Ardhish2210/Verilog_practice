module esa3 (a, b, sum);

input [7:0] a, b;
output [8:0] sum;

wire carry_3;
wire [2:0] sum_1, sum_2;
wire [1:0] sum_3;

assign sum_1 = a[2:0] ^ b[2:0];
assign sum_2 = a[5:3] ^ b[5:3];

assign {carry_3, sum_3} = {1'b0, a[7:6]} + {1'b0, b[7:6]};

assign sum = {carry_3, sum_3, sum_2, sum_1};

endmodule