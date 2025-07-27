`timescale 1ns/1ns
`include "btog_converter.v"

module btog_converter_tb; 

reg [3:0] binary_num;
wire [3:0] gray_code;

btog_converter uut (binary_num, gray_code);

initial begin 
    $dumpfile("btog_converter.vcd");
    $dumpvars();

    $monitor("$Time: %0t || binary: %04b || gray_code: %04b", $time, binary_num, gray_code);
    binary_num = 4'b0000;

    #3 binary_num = 4'b0000;
    #10 binary_num = 4'b0001;
    #10 binary_num = 4'b0010;
    #10 binary_num = 4'b0011;
    #10 binary_num = 4'b0100;
    #10 binary_num = 4'b1111;

    #10 $finish;
end
endmodule