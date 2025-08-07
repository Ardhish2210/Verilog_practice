module scsa (a, b, sum, cout);

input [3:0] a, b;
output [3:0] sum;
output cout;

// the LSB's are added directly without any carry_in (approx)
assign sum[1:0] = a[1:0] + b[1:0];
    
endmodule