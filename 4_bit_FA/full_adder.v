module full_adder(a, b, cin, sum, cout);

// In this module I will make the full adder cicuit using the gate level modeling (structural modeling)

input a, b, cin;
output sum, cout;

wire w1, w2, w3, w4;

xor x1 (w1, a, b);
xor x2 (sum, w1, cin);
and x3 (w2, a, b);
and x4 (w3, b, cin);
and x5 (w4, cin, a);
or x6 (cout, w2, w3, w4);

endmodule