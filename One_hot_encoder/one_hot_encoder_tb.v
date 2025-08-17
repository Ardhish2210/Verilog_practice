module one_hot_encoder_tb;

reg [2:0] a;
wire [7:0] out;

one_hot_encoder uut (a, out);

initial begin

    $dumpfile("one_hot_encoder.vcd");
    $dumpvars(0, one_hot_encoder_tb);

    $monitor("a: %d || out: %08b", a, out);

    a = 3'b000;

    #10 a = 3'b001;
    #10 a = 3'b010;
    #10 a = 3'b100;
    #10 a = 3'b111;

    #10 $finish;
end
endmodule