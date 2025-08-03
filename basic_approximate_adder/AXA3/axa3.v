module axa3 (a, b, cin, sum, cout);

input a, b, cin;
output sum, cout;

assign sum = ~(a ^ b);
assign cout = 0;
    
endmodule