// NOTE: This module is having with correct logic, but is not able to generate the SCHEMATIC DESIGN in Xilinx vivado software, I am working on the issue...

module music_player (clk, rst, play_pause, next, prev, is_playing, song);

input clk, rst, play_pause, next, prev;
output reg is_playing;
output reg [1:0] song;

// play_pause: Play/Pause toggle button
// next: Next song button
// prev: Previous song button
// is_playing: Output high when playing, low when paused
// song: Current song number (0 to 3)
 
parameter IDLE = 2'b00, PLAYING = 2'b01, PAUSE = 2'b10, NEXT = 2'b00;
reg [1:0] state, next_state;

always @(posedge clk or posedge rst) begin
    if (rst) begin
        is_playing <= 1'b0;
        song <= 2'b00;
        state <= IDLE;
    end else begin
        state <= next_state;
    end

    if (play_pause) begin
        is_playing <= ~is_playing;
    end

    if (is_playing) begin
        if (next && !prev) begin
            song <= (song == 2'd3) ? 0: song + 1;        
        end else if (!next && prev) begin
            song <= (song == 2'd0) ? 3: song - 1; 
        end
    end
end

always @(*) begin
    case (state)
    IDLE: begin
        next_state = (is_playing == 1'b1) ? PLAYING:IDLE;
    end 
    PLAYING: begin
        next_state = (is_playing == 1'b1) ? PLAYING:PAUSE;
    end
    PAUSE: begin
        next_state = (is_playing == 1'b1) ? PLAYING:PAUSE;
    end
    endcase
end
endmodule
