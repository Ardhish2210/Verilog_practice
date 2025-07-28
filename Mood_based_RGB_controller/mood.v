module mood (brain_wave, clk, rst, rgb, blink);

input [1:0] brain_wave; // 00-calm, 01-focused, 10-anxious, 11-excited
input clk, rst;
output [2:0] rgb; // rgb[0]=Blue, rgb[1]=Green, rgb[2]=Red,
output blink; // blink = 1 (if ANXIOUS or EXCITED mode is ON)
endmodule