module bcd_counter (clk, rst, out);

input clk, rst;
output reg [3:0] out; 

always @(posedge clk or posedge rst) begin
    if(rst) out <= 4'b0000;
    else if (out == 4'b1001) out <= 4'b0000;
    else out <= out + 1;
end
endmodule
