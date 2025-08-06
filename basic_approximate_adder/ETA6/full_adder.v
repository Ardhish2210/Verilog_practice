module full_adder (a, b, cin, sum, cout);
        input a, b, cin;
        output cout, sum;

        assign sum = a ^ b ^ cin;
        assign cout = (a&b) | (b&cin) | (a&cin);
    endmodule