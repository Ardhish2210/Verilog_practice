module esa3_tb; 

reg [7:0] a,b;
wire [8:0] sum;

esa3 uut (a, b, sum);

initial begin
    $dumpfile("esa3.vcd");
    $dumpvars(0, esa3_tb);

    $monitor("a: %08b || b: %08b || sum: %09b", a, b, sum);

end






endmodule