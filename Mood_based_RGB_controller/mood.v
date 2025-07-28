module mood (brain_wave, clk, rst, rgb, blink);

input [1:0] brain_wave; // 00-calm, 01-focused, 10-anxious, 11-excited
input clk, rst;
output reg [2:0] rgb; // rgb[0]=Blue, rgb[1]=Green, rgb[2]=Red,
output reg blink; // blink = 1 (if ANXIOUS or EXCITED mode is ON)

always @(*) begin
    case (brain_wave)

    2'b00: begin // CALM state
        rgb = 3'b000; /// blue
        blink = 1'b0;
    end
    2'b01: begin // FOCUSED state
        rgb = 3'b010; /// blue
        blink = 1'b0;
    end
    2'b10: begin // ANXIOUS state
        rgb = 3'b100; /// blue
        blink = 1'b1;
    end
    2'b11: begin // EXCITED state
        rgb = 3'b101; /// blue
        blink = 1'b1;
    end
    endcase
end


endmodule