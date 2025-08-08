module cla (a, b, sum, cin,cout);

input [3:0] a, b;
input cin;
output [3:0] sum;
wire [3:0] P, G; // P = propagation carry, G = Generated carry
wire [3:0] C;

// for 0th bit
assign P[0] = a[0] ^ b[0];
assign G[0] = a[0] & b[0];
assign C[0] = cin;
assign sum[0] = P[0] ^ C[0];


endmodule