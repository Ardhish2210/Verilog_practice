module sr_latch (s, r, clk, rst, q);

input s, r, clk, rst;
output reg q;

always @(posedge clk or posedge rst) begin
    if(rst) begin
        q <= 0;
    end else begin
        casex ({~s, ~r})
        2'b00: q <= q;
        2'b01: q <= 1'b0;
        2'b10: q <= 1'b1;
        2'b11: q <= 1'bx;
        default: begin
            q <= 1'b0;
        end
        endcase
    end
end
endmodule