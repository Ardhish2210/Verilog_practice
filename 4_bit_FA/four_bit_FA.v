module four_bit_FA (a, b, c_in, sum, c_out);
    
input [3:0] a, b;
input c_in;
output [3:0] sum;
output c_out;
wire [2:0] c;

adder add_1 (a[0], b[0], c_in, sum[0], c[0]);
adder add_2 (a[1], b[1], c[0], sum[1], c[1]);
adder add_3 (a[2], b[2], c[1], sum[2], c[2]);
adder add_4 (a[3], b[3], c[2], sum[3], c_out);

endmodule


    module adder (a, b, c, sum, c_out);
        input a, b, c;
        output c_out, sum;

        assign sum = a ^ b ^ c;
        assign c_out = (a&b) | (b&c) | (a&c);
    endmodule
