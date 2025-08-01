module approx_adder (a, b, cin, sum, cout);

input a, b, cin;
output sum, cout;

// The mai use of approximate adders is in ML and AL filed where it is used to numerous calculations quickly and effeciently, Here as "Cin" is not considered the area, power and cost of the overall adder is decreased    
assign sum = a ^ b;
assign cout = a & b;
    
endmodule