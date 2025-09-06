`include "full_adder.v"

module ripple_carry_adder (a, b, cin, sum, cout);

    input  [15:0] a, b;
    input cin;
    output [15:0] sum;
    output cout;
    wire [15:0] carry;

    full_adder fa0 (.a(a[0]), .b(b[0]), .cin(cin), .sum(sum[0]), .cout(carry[0]));

    genvar i;
    generate 
        for (i = 1; i < 16; i = i + 1) begin : fa_loop
            full_adder fa (.a(a[i]), .b(b[i]), .cin(carry[i-1]), .sum(sum[i]), .cout(carry[i]));
        end
    endgenerate

    assign cout = carry[15];

endmodule
