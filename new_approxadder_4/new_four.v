// `include "ripple_carry_adder.v"
//`include "full_adder.v"

module new_four (a, b, sum);

input [31:0] a, b;
output [32:0] sum;
wire cmsp;

assign sum[14:0] = a[14:0] | b[14:0];
assign cmsp = a[15] & b[15];
// assign sum[15] = (cmsp) ? 0 : a[15]|b[15];
assign sum[15] = a[15] ^ b[15] ^ cmsp;

wire [16:0] temp_sum;
assign {temp_sum} = {1'b0, a[31:16]} + {1'b0, b[31:16]} + cmsp;
assign sum[31:16] = temp_sum[15:0];
assign sum[32] = temp_sum[16];


// ripple_carry_adder r1 (.a(a[31:16]), .b(b[31:16]), .cin(cmsp), .sum(sum[31:16]), .cout(sum[32]));

endmodule