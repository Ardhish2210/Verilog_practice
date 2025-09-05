`timescale 1ns/1ns
`include "scsa.v"

module scsa_tb;

reg [7:0] a, b;
wire [7:0] sum;
wire cout;

scsa uut (a, b, sum, cout);

initial begin 
    $dumpfile("scsa.vcd");
    $dumpvars(0, scsa_tb);

    $monitor("Time: %0t || a: %d || b: %d || sum: %d || cout: %b", $time, a, b, sum, cout);

    a = 8'd0; b = 8'd0;

    #10 a = 8'd10; b = 8'd1; 
    #10 a = 8'd15; b = 8'd14; 
    #10 a = 8'd50; b = 8'd34; 
    #10 a = 8'd49; b = 8'd28; 

    #10 $finish; 
end

endmodule