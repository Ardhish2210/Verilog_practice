`timescale 1ns/1ns
`include "decoder.v"

module decoder_tb;

    reg [2:0] sel;
    reg enable;
    wire [7:0] out;

    decoder uut (.sel(sel), .enable(enable), .out(out));

    initial begin
        
        $monitor("Time = %0t || sel = %b || enable = %b || out = %b", $time, sel, enable, out);

        enable = 1;

        #5 sel = 3'b000;
        #5 sel = 3'b001;
        #5 sel = 3'b010;
        #5 sel = 3'b011;
        #5 sel = 3'b100;
        #5 sel = 3'b101;
        #5 sel = 3'b110;
        #5 sel = 3'b111;

        #5 $display("The program is successfully completed");
        #5 $finish;
    end

    initial begin
        $dumpfile("decoder_tb.vcd");
        $dumpvars(0, decoder_tb);
    end

endmodule
