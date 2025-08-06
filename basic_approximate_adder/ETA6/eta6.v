module eta6 (A, B, SUM, COUT);

input [5:0] A, B;
output [5:0] SUM;
output COUT;
// for bits 0 to 2, no carry is considered, carry is only considered from 3 to 6 bits
wire sum_0, sum_1, sum_2;

assign sum_0 = A[0] ^ B[0];   
assign sum_1 = A[1] ^ B[1];
assign sum_2 = A[2] ^ B[3]; 





endmodule