module decoder (a, out);

input [1:0] a;
output [3:0] out;

assign out[0] = (~a[1]) & (~a[0]);
assign out[1] = (~a[1]) & (a[0]);
assign out[2] = (a[1]) & (~a[0]);
assign out[3] = (a[1]) & (a[0]);
    
endmodule