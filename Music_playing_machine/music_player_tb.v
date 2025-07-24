`timescale 1ns/1ns
`include "music_player.v"

module music_player_tb;

reg clk, rst, play_pause, next, prev;
wire is_playing;
wire [1:0] song;

music_player uut (clk, rst, play_pause, next, prev, is_playing, song);

initial begin
    $dumpfile("music_player.vcd");
    $dumpvars(0, music_player_tb);

    $monitor("Time: %0t || play_pause: %0b || next: %0b || prev: %0b || is_playing: %0b || song: %0d", $time, play_pause, next, prev, is_playing, song);

    clk = 0;
    rst = 1;
    play_pause = 0;
    next = 0;
    prev = 0;

    #5 rst = 0;  

    // Test Vector 1: 
    #5  play_pause = 1; next = 0; prev = 0; 
    #10 play_pause = 0;                      

    // Test Vector 2: 
    #10 play_pause = 0; next = 1; prev = 0;  
    #10 next = 0;                            

    // Test Vector 3:
    #10 play_pause = 0; next = 1; prev = 0;  
    #10 next = 0;                            
    // Test Vector 4: 
    #10 play_pause = 0; next = 0; prev = 1;  
    #10 prev = 0;        

    // Test vector 5:
    #10 play_pause = 1; next = 0; prev = 0;  
    #10 play_pause = 0;                      

    #10 $finish;
end

always #5 clk = ~clk;

endmodule
