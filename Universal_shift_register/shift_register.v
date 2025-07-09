module shift_register (clk, rst, sel, d, q);

input clk;
input rst;
input [1:0] sel;    
input [3:0] d;
output reg [3:0] q;

// 00 - Hold, 01 - Shift Right, 10 - Shift Left, 11 - Parallel Load
always @(posedge clk or posedge rst) begin
    if (rst)
        q <= 4'b0000;
    else begin
        case (sel)
            2'b00: q <= q;          
            2'b01: q <= q >> 1;     
            2'b10: q <= q << 1;     
            2'b11: q <= d;  // Parallel Load
        endcase
    end
end

endmodule
