`timescale 1ps/1ps
`include "vedic_two.v"

module vedic_two_tb;

reg [0:1] a,b;
wire [0:3] out;

vedic_two uut (.a(a), .b(b), .out(out));

initial begin
        $dumpfile("vedic_two.vcd");
        $dumpvars(0, vedic_two_tb);
        
        a = 2'b00; b = 2'b00; #10; // 0 x 0
        a = 2'b01; b = 2'b01; #10; // 1 x 1
        a = 2'b10; b = 2'b10; #10; // 2 x 2
        a = 2'b11; b = 2'b11; #10; // 3 x 3
        a = 2'b10; b = 2'b01; #10; // 2 x 1
        a = 2'b11; b = 2'b01; #10; // 3 x 1

        $finish;

end

initial begin
        $monitor("At time %t || a = %b || b = %b || out = %b", $time, a, b, out);
end

endmodule