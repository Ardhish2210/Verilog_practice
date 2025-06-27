module four_bit_subtractor (a, b, sub, borrow);
    
    input [3:0] a;
    input [3:0] b;
    output [3:0] sub;
    output borrow;

    wire [4:0] temp;

    assign temp = {1'b0, a} + {1'b0, ~b} + 5'b00001; // A + (~B + 1)
    assign sub = temp[3:0];
    assign borrow = ~temp[4];
endmodule
