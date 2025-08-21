`timescale 1ns/1ns
`include "decoder.v"

module decoder_tb;

reg [1:0] a;
wire [3:0] out;

decoder uut (a, out);

initial begin

    $dumpfile("decoder.vcd");
    $dumpvars(0, decoder_tb);

    $monitor("a: %b || out: %b", a, out);

    a = 2'b00;

    #10 a = 2'b00;
    #10 a = 2'b01;
    #10 a = 2'b10;
    #10 a = 2'b11;

    #10 $finish;
end

    
endmodule