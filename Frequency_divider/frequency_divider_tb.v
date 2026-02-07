`timescale 1ns/1ns
`include "prep.v"

module freq_divider_tb;

reg clk, rst;
wire clk_out;

freq_divider dut (.clk(clk), .rst(rst), .clk_out(clk_out));

initial begin
    clk = 1'b0;
    rst = 1'b1; 

    #10; rst = 1'b0;

    $monitor("time: %0t || clk: %0b || clk_out: %0b", $time, clk, clk_out);
    #200; $finish;
end

initial begin
    $dumpfile("output.vcd");
    $dumpvars();
end

always #10 clk = ~clk;

endmodule
