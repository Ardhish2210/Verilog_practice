module four_bit_counter (clk, clr, ld, in, out);

input ld, clr, clk;
input [3:0] in;
output [3:0] out;

reg [3:0] count;

always @(posedge clk) begin
    if (clr) begin
        count <= 4'b0000;
    end else if (ld) begin
        count <= in;
    end else begin
        count <= count + 1;
    end
end

assign out = count;

endmodule
