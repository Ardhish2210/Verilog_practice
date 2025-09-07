module sr_latch (s, r, en, rst, q);

input s, r, en, rst;
output reg q;

always @(*) begin
    if (rst) begin
        q <= 0;
    end else if (en) begin
        casex ({s, r})
        2'b00: q <= q;
        2'b01: q <= 1'b0;
        2'b10: q <= 1'b1;
        2'b11: q <= 1'bx;
        endcase
    end
end
endmodule