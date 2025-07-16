module vedic_two (a, b, out);
    input [1:0] a;
    input [1:0] b;
    output [3:0] out;
    wire w1, w2, w3, w4, sum, sum2, cout1, cout2;

    and (w1, a[0], b[0]);
    and (w2, a[1], b[0]);
    and (w3, a[0], b[1]);
    and (w4, a[1], b[1]);

    half_adder h1 (.x(w2), .y(w3), .sum(sum), .cout(cout1));
    half_adder h2 (.x(w4), .y(cout1), .sum(sum2), .cout(cout2));

    assign out = {cout2, sum2, sum, w1};
    
endmodule

module half_adder (x,y,sum,cout);
    input x,y;
    output sum,cout;

    assign sum = x ^ y;
    assign cout = x & y;
endmodule
