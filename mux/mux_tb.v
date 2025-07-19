`timescale 1ns/1ns
`include "mux.v"

module mux_tb;

reg [3:0] a;
reg [1:0] sel;
wire out;

mux uut (.a(a), .sel(sel), .out(out));

initial begin 
    $monitor("a: %0b || sel: %0d || out: %0b", a, sel, out);

    #3 a = 4'b1010; sel = 2'b00;
    #3 a = 4'b1010; sel = 2'b01;
    #3 a = 4'b1010; sel = 2'b10;
    #3 a = 4'b1010; sel = 2'b11;

    #3  $display("The program is successfully completed");
    #3  $finish;

end
    
initial begin
    $dumpfile("mux_tb.vcd");
    $dumpvars(0, mux_tb);    
end

endmodule
