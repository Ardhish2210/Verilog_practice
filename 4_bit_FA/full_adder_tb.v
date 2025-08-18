`timescale 1ns/1ns
`include "full_adder.v"

module full_adder_tb;

reg a, b, cin;
wire sum, cout;
integer i;

full_adder uut (a, b, cin, sum, cout);

initial begin

    $dumpfile("full_adder.vcd");
    $dumpvars(0, full_adder_tb);

    $monitor("a: %0b || b: %0b || cin: %0b || sum: %0b || cout: %0b", a, b, cin, sum, cout);

    for (i = 0; i < 8; i = i + 1) begin
        {a, b, cin} = i;
        #5;
    end

    #10 $finish;
end

endmodule