`timescale 1ps/1ps
`include "16_bit_FA.v"

module tb_full_adder_16bit;

    // Testbench signals
    reg [15:0] A;       // 16-bit input A
    reg [15:0] B;       // 16-bit input B
    reg Cin;            // Carry input
    wire [15:0] Sum;    // 16-bit output Sum
    wire Cout;          // Carry output

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
        // Test case 1: Add 16'h0000 + 16'h0000 + 0
        A = 16'h0000; B = 16'h0000; Cin = 0;
        #10;

        // Test case 2: Add 16'h0001 + 16'h0001 + 0
        A = 16'h0001; B = 16'h0001; Cin = 0;
        #10;

        // Test case 3: Add 16'hFFFF + 16'h0001 + 0
        A = 16'hFFFF; B = 16'h0001; Cin = 0;
        #10;

        // Test case 4: Add 16'h1234 + 16'h5678 + 1
        A = 16'h1234; B = 16'h5678; Cin = 1;
        #10;

        // Test case 5: Add 16'hAAAA + 16'h5555 + 0
        A = 16'hAAAA; B = 16'h5555; Cin = 0;
        #10;

        // Test case 6: Add 16'h8000 + 16'h7FFF + 1
        A = 16'h8000; B = 16'h7FFF; Cin = 1;
        #10;

        // Test case 7: Add 16'hFFFF + 16'hFFFF + 1
        A = 16'hFFFF; B = 16'hFFFF; Cin = 1;
        #10;

        // End simulation
        $finish;
    end

    // Monitor the results
    initial begin
        $monitor("Time: %0t | A: %h | B: %h | Cin: %b | Sum: %h | Cout: %b",
                 $time, A, B, Cin, Sum, Cout);
    end

endmodule
