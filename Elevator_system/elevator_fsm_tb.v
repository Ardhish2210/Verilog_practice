`timescale 1ns/1ns
`include "elevator_fsm.v"

module elevator_fsm_tb;

reg [1:0] current_floor;
reg clk, rst, up_request;
wire [1:0] direction;

elevator_fsm uut (clk, rst, up_request, current_floor, direction);

// DIRECTIONS
// 00 = Stay
// 01 = Go Up
// 10 = Go Down

initial begin
    $dumpfile("elevator_fsm.vcd");
    $dumpvars(0, elevator_fsm_tb);

    $monitor("Time: %0t || rst: %0b || current_floor: %0d || up_request: %0b || direction: %02b", $time, rst, current_floor, up_request, direction);

    clk = 0;
    rst = 1;
    up_request = 1'b0;
    current_floor = 2'b00;
    #5 rst= 0;

    #3 current_floor = 2'b00  ; up_request = 1'b0;
    #10 current_floor = 2'b01  ; up_request = 1'b0;
    #10 current_floor = 2'b01  ; up_request = 1'b1;
    #10 current_floor = 2'b10  ; up_request = 1'b1;
    #10 current_floor = 2'b11  ; up_request = 1'b1;
    #10 current_floor = 2'b00  ; up_request = 1'b0;

    #20 $finish;
end

always #5 clk = ~clk;

endmodule