module approx_adder (a, b, cin, sum, cout);

input a, b, cin;
output sum, cout;

assign sum = a ^ b;
assign cout = a & b;
    
endmodule