`timescale 1ps/1ps
`include "four_bit_FA.v"

module four_bit_FA_tb;

reg [3:0] a;
reg [3:0] b;
reg c_in;

wire [3:0] sum;
wire c_out;

four_bit_FA uut (a, b, c_in, sum, c_out); 

initial begin
    $monitor("Time: %d, a = %b, b = %b, c_in = %b, sum = %b, c_out = %b",
              $time, a, b, c_in, sum, c_out);

    #5  a = 4'b1001; b = 4'b1101; c_in = 0;
    #10 a = 4'b0011; b = 4'b0101; c_in = 1;
    #10 a = 4'b1111; b = 4'b1111; c_in = 1;

    #10 $display("The program is successfully completed");
    #10 $finish;
end

endmodule
