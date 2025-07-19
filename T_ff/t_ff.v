module t_ff (t, clk, rst, q);

input t, clk, rst;
output reg q;
    
always @(posedge clk or posedge rst) begin
    if(rst) begin
        q <= 1'b0;
    end else begin
        case (t)
        1'b0: q <= q;
        1'b1: q <= ~q;
    endcase
    end
end 
endmodule
