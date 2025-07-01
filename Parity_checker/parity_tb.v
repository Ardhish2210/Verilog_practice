`timescale 1ns/1ns 
`include "parity.v"

module parity_tb();

reg [3:0] in;
wire out;

parity_generator uut (in, out);

initial begin 
    $monitor("input: %0b || output: %0d", in, out);

    #2 in = 4'b1101;
    #2 in = 4'b1111;
    #2 in = 4'b1001;
    #2 in = 4'b1000;    
end

initial begin
  $dumpfile("parity.vcd");
  $dumpvars(0, parity_tb);
end

endmodule
