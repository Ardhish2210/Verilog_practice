module encoder_tb; 

reg [2:0] a;
reg enable;
wire [7:0] out;

encoder uut (a, enable, out);

initial begin

    $dumpfile("encoder.vcd");
    $dumpvars(0, encoder_tb);

    $monitor("Time: %0t || a: %b || enable: %b || out: %b", $time, a, enable, out);


    

end
    
endmodule