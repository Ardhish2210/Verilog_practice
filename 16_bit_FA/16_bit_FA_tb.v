`timescale 1ps/1ps
`include "16_bit_FA.v"

module tb_full_adder_16bit;

    reg [15:0] A;       
    reg [15:0] B;       
    reg Cin;            
    wire [15:0] Sum;    
    wire Cout;          

    // Instantiate the 16-bit full adder
    full_adder_16bit uut (
        .A(A),
        .B(B),
        .Cin(Cin),
        .Sum(Sum),
        .Cout(Cout)
    );

    // Test sequence
    initial begin
        
        A = 16'h0000; B = 16'h0000; Cin = 0;
        #10;
        
        A = 16'h0001; B = 16'h0001; Cin = 0;
        #10;

        A = 16'hFFFF; B = 16'h0001; Cin = 0;
        #10;

        A = 16'h1234; B = 16'h5678; Cin = 1;
        #10;

        A = 16'hAAAA; B = 16'h5555; Cin = 0;
        #10;

        A = 16'h8000; B = 16'h7FFF; Cin = 1;
        #10;

        A = 16'hFFFF; B = 16'hFFFF; Cin = 1;
        #10;

        $finish;
    end

    initial begin
        $monitor("Time: %0t | A: %h | B: %h | Cin: %b | Sum: %h | Cout: %b",
                 $time, A, B, Cin, Sum, Cout);
    end

endmodule
