module priority_encoder (
    input [7:0] a,
    input valid,
    output reg [2:0] out
);

always @(*) begin
    if (!valid)
        out = 3'b000;
    else begin
        casex (a)
            8'b1xxxxxxx: out = 3'b111;
            8'b01xxxxxx: out = 3'b110;
            8'b001xxxxx: out = 3'b101;
            8'b0001xxxx: out = 3'b100;
            8'b00001xxx: out = 3'b011;
            8'b000001xx: out = 3'b010;
            8'b0000001x: out = 3'b001;
            8'b00000001: out = 3'b000;
            default:     out = 3'b000;
        endcase
    end
end

endmodule
