`timescale 1ns/1ns
`include "shift_register.v"

module shift_register_tb;

reg clk, rst;
reg [1:0] sel;
reg [3:0] d;
wire [3:0] q;

shift_register uut (.clk(clk), .rst(rst), .sel(sel), .d(d), .q(q));

always #5 clk = ~clk;

initial begin

    $dumpfile("shift_register.vcd");
    $dumpvars(0, shift_register_tb);

    $monitor("time: %0t || sel: %02b || d: %04b || q: %04b", $time, sel, d, q);

    clk = 0; 
    rst = 1; sel = 2'b00; d = 4'b0000;
    #10 rst = 0;

    #10 sel = 2'b11; d = 4'b1010;
    #10 sel = 2'b00;
    #10 sel = 2'b01;
    #10 sel = 2'b10;
    #10 sel = 2'b11; d = 4'b1100;
    #10 sel = 2'b01;
    #10 sel = 2'b01;
    #10 sel = 2'b10;
    #10 sel = 2'b10;

    #20 $finish;
end

endmodule
