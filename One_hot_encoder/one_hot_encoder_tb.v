module one_hot_encoder_tb;

reg [2:0] a;
wire [7:0] out;

one_hot_encoder uut (a, out);
endmodule