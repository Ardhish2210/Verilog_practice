`timescale 1ns/1ns
`include "comparator.v"

module comparator_tb;

reg [3:0] a, b;
wire LT, GT, EQ;

comparator uut (.a(a), .b(b), .LT(LT), .EQ(EQ), .GT(GT));

initial begin 
    $dumpfile("comparator.vcd");
    $dumpvars(0, comparator_tb);

    $monitor("a: %04b || b: %04b || LT: %01b GT: %01b EQ: %01b", a, b, LT, GT, EQ);

    #2 a = 4'b1011; b = 4'b1011;
    #2 a = 4'b1111; b = 4'b1011;
    #2 a = 4'b1001; b = 4'b1000;
    #2 a = 4'b0001; b = 4'b0011;

    #2 $finish;
end
endmodule