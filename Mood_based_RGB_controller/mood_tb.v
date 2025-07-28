module mood_tb; 

reg [1:0] brain_wave;
reg clk, rst;
wire [2:0] rgb;
wire blink;

mood uut (brain_wave, clk, rst, rgb, blink);


    
endmodule