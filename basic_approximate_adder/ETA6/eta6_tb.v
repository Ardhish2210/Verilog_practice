`timescale 1ns/1ns
`include "eta6.v"

module eta6_tb;

reg [5:0] A, B;
wire [5:0] SUM;
wire COUT;

eta6 uut (A, B, SUM, COUT);

initial begin
    
    $dumpfile("eta6,vcd");
    $dumpvars(0, eta6_tb);

    $monitor("A: %06b || B: %06b || SUM: %06b || COUT: %0b", A, B, SUM, COUT);

    A = 6'b000000; B= 6'b000000;
    #10 A = 6'b000000; B= 6'b000000;
    #10 A = 6'b111000; B= 6'b110110;
    #10 A = 6'b010110; B= 6'b101101;
    #10 A = 6'b111111; B= 6'b111111;

    #10 $finish;
end
endmodule