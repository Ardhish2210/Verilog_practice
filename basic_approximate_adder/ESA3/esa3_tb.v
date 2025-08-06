module esa3_tb; 

reg [7:0] a,b;
wire [8:0] sum;

esa3 uut (a, b, sum);

initial begin
    $dumpfile("esa3.vcd");
    $dumpvars(0, esa3_tb);

    $monitor("a: %08b || b: %08b || sum: %09b", a, b, sum);

    a = 8'b00000000; b = 8'b00000000;
    #10 a = 8'b00000001; b = 8'b00000100;
    #10 a = 8'b00111000; b = 8'b11101100;
    #10 a = 8'b11001100; b = 8'b10110011;
    #10 a = 8'b10100111; b = 8'b11110000;

    #10 $finish;
end
endmodule