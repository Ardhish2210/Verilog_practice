module scsa_tb;

reg [3:0] a, b;
wire [3:0] sum; 
wire cout;

scsa uut (a, b, sum, cout);

initial begin 
    $dumpfile("scsa.vcd");
    $dumpvars(0, scsa_tb);

    $monitor("a: %04b || b: %04b || sum: %04b || cout: %0b", a, b, sum, cout);

    a = 4'b0000; b = 3'b0000;
    #10 a = 4'b0011; b = 4'b1101;
    #10 a = 4'b1111; b = 4'b1101;
    #10 a = 4'b1110; b = 4'b1001;

    #10 $finish;
end
    
endmodule