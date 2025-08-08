`timescale 1ns/1ns
`include "cla.v"

module cla_tb; 

reg [3:0] a, b;
reg cin;
wire [3:0] sum;
wire cout;

cla uut (a, b, sum, cin, cout);

initial begin
    $dumpfile("cla.vcd");
    $dumpvars(0, cla_tb);

    $monitor("a: %04b || b: %04b || cin: %0b || sum: %04b || cout: %0b", a, b, cin, sum, cout);

    a = 4'b0; b = 4'b0; cin = 0;

    #10 a = 4'b1101; b = 4'b0101; cin = 1;
    #10 a = 4'b1111; b = 4'b1101; cin = 0;
    #10 a = 4'b1001; b = 4'b0001; cin = 1;
    #10 a = 4'b0110; b = 4'b0111; cin = 0;

    #10 $finish;
end
endmodule