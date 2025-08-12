module risingedgedetector (clk, d, rst, out);
  
reg q;
input clk;
input d; 
input rst;
output reg out;

always @(posedge clk or posedge rst) begin
    if (rst) begin
        q <= 1'b0;
        out <= 1'b0;
    end else begin
        out <= d & ~q;  
        q <= d;       
        end
    end
  
endmodule
