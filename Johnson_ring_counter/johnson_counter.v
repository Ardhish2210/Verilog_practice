module johnson_counter (clk, rst, q);

input clk;
input rst;
output reg [3:0] q;

always @(posedge clk or posedge rst) begin
    if (rst)
        q <= 4'b0000;
    else begin
        q <= {q[2:0], ~q[3]};
    end
end

endmodule
