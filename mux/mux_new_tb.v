`timescale 1ns/1ns
`include "mux_new.v"

module mux_new_tb;

reg [1:0] a;
reg  sel;
wire out;

mux_new uut (.a(a), .sel(sel), .out(out));

initial begin 
    $dumpfile("mux_new_tb.vcd");
    $dumpvars(0, mux_new_tb); 

    $monitor("a: %02b || sel: %0d || out: %0b", a, sel, out);

    a = 2'b00; sel = 1'b0;

    #3 a = 2'b00; sel = 1'b0;
    #3 a = 2'b01; sel = 1'b1;
    #3 a = 2'b10; sel = 1'b0;
    #3 a = 2'b11; sel = 1'b0;

    #3  $finish;

end
    
endmodule
