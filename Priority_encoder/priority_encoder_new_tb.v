`timescale 1ns/1ns
`include "priority_encoder_new.v"

module priority_encoder_new_tb;

reg valid;
reg [7:0] d;
wire [2:0] out;

priority_encoder_new uut (d, out, valid);

initial begin

    $dumpfile("priority_encoder_new.vcd");
    $dumpvars(0, priority_encoder_new_tb);

    $monitor("valid: %0b || d: %08b || out: %03b", valid, d, out);

    valid = 1'b0;
    d = 8'b0000_0000;
    
    #3 valid = 1'b1; d = 8'b0000_0001;
    #3 valid = 1'b1; d = 8'b0000_0010;
    #3 valid = 1'b1; d = 8'b0000_0100;
    #3 valid = 1'b1; d = 8'b0000_1000;
    #3 valid = 1'b1; d = 8'b0001_0000;
    #3 valid = 1'b1; d = 8'b0010_0000;
    #3 valid = 1'b1; d = 8'b0100_0000;
    #3 valid = 1'b1; d = 8'b1000_0000;

    #10 $finish;
end

endmodule