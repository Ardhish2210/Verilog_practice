module xor_using_nand (a, b, y);

input a, b;
output y;

wire d, e, f;

nand g1 (d, a, b);
nand g2 (e, a, d);
nand g3 (f, d, b);
nand g4 (y, f, e);

endmodule