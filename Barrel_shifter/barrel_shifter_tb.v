`timescale 1ns/1ns
`include "barrel_shifter.v"

module barrel_shifter_tb;

reg [1:0] sel;
reg [3:0] a;
reg [1:0] N;
wire [3:0] out;
    
barrel_shifter uut (.a(a), .sel(sel), .out(out), .N(N));

initial begin
    $dumpfile("barrel_shifter.vcd");
    $dumpvars();

    $monitor("input: %04b || sel: %02b || output: %04b", a, sel, out);

    #2 a = 4'b1011; sel = 2'b00; N = 2'b01;
    #2 a = 4'b1011; sel = 2'b01; N = 2'b01;
    #2 a = 4'b1011; sel = 2'b10; N = 2'b01;
    #2 a = 4'b1011; sel = 2'b11; N = 2'b01;

    #2 $finish;

end
endmodule
