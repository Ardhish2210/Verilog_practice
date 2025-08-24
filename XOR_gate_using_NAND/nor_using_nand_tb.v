`timescale 1ns/1ns
`include "xor_using_nand.v"

module xor_using_nand_tb;

reg a, b;
wire y;

initial begin

    $dumpfile("xor_using_nand.v");
    $dumpvars(0, xor_using_nand_tb);

    $monitor("a: %b || b: %b || out: %b", a, b, y);

    a = 1'b0; b = 1'b0; 
    #10 a = 1'b0; b = 1'b1; 
    #10 a = 1'b1; b = 1'b0;
    #10 a = 1'b1; b = 1'b1;

    #10 $finish;
end
endmodule