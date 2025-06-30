`timescale 1ns/1ns
`include "priority_encoder.v"

module priority_encoder_tb ();

reg [7:0] a;
reg valid;
wire [2:0] out;

priority_encoder uut (.a(a), .out(out), .valid(valid));

initial begin

    $monitor ("a: %0b || valid: %0b || out: %0b", a, valid, out);

    a = 8'b00000001; valid = 1; #10;
    a = 8'b00001000; valid = 1; #10; 
    a = 8'b01000100; valid = 1; #10;
    a = 8'b11111111; valid = 1; #10; 
    a = 8'b10000000; valid = 0; #10;
    a = 8'b00000000; valid = 1; #10;
    $finish;

end

initial begin
    $dumpfile("priority_encoder.vcd");
    $dumpvars(0,priority_encoder_tb);
end
  
endmodule
