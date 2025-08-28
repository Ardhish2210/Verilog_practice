`timescale 1ns/1ns
`include "pwm.v"

module pwm_tb;

reg clk, rst;
reg [7:0] duty_cycle;
wire pwm_out;

initial begin 

    $dumpfile("pwm.vcd");
    $dumpvars(0, pwm_tb);

    $monitor("Time: %0t || clk: %b || rst: %b || duty_cycle: %d || pwm_out: %b", $time, clk, rst, duty_cycle, pwm_out);

    clk = 1'b0;
    duty_cycle = 0;
    rst = 1'b1;

    #5 rst = 1'b0;

    #5 duty_cycle = 60;
    #10 duty_cycle = 60;
    #10 duty_cycle = 60;
    #10 duty_cycle = 60;
    #10 duty_cycle = 60;
    #10 duty_cycle = 60;

    #10 $finish;
end
    
endmodule