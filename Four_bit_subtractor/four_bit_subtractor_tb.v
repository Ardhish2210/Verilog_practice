`timescale 1ns/1ns
`include "four_bit_subtractor.v"

module four_bit_subtractor_tb;

    reg [3:0] a;
    reg [3:0] b;
    wire [3:0] sub;
    wire borrow;

    four_bit_subtractor uut (.a(a), .b(b), .sub(sub), .borrow(borrow));

    initial begin
    
        $monitor("a: %0d || b: %0d || sub: %0d || borrow: %0d", a, b, sub, borrow);

        #3  a = 4'b1001;  b = 4'b0100;  // 9  - 4  = 5
        #3  a = 4'b0011;  b = 4'b0111;  // 3  - 7  = -4 (borrow)
        #3  a = 4'b1111;  b = 4'b0001;  // 15 - 1  = 14
        #3  a = 4'b0101;  b = 4'b0101;  // 5  - 5  = 0
        #3  a = 4'b0000;  b = 4'b0001;  // 0  - 1  = -1 (borrow)
        #3  a = 4'b0110;  b = 4'b0011;  // 6  - 3  = 3

        #1  $display("The program is successfully completed");
        #1  $finish;
    end

    initial begin 
        $dumpfile("four_bit_subtractor_tb.vcd");
        $dumpvars(0, four_bit_subtractor_tb);
    end
endmodule