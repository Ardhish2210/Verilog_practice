module cla (a, b, sum, cin, cout);

input [3:0] a, b;
input cin;
output [3:0] sum;
output cout;
wire [3:0] P, G; // P = propagation carry, G = Generated carry
wire [3:0] C;

// for 0th bit
assign P[0] = a[0] ^ b[0];
assign G[0] = a[0] & b[0];
assign C[0] = cin;
assign sum[0] = P[0] ^ C[0];

// for 1st bit
assign P[1] = a[1] ^ b[1];
assign G[1] = a[1] & b[1];
assign C[1] = G[0] | (P[0] & C[0]);
assign sum[1] = P[1] ^ C[1];

// for 2nd bit
assign P[2] = a[2] ^ b[2];
assign G[2] = a[2] & b[2];
assign C[2] = G[1] | (P[1] & C[1]);
assign sum[2] = P[2] ^ C[2];

// for 3rd bit
assign P[3] = a[3] ^ b[3];
assign G[3] = a[3] & b[3];
assign C[3] = G[2] | (P[2] & C[2]);
assign sum[3] = P[3] ^ C[3];

assign cout = C[3];

endmodule