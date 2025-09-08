module comparator(a, b, LT, GT, EQ);
    
input [3:0] a, b;
output reg LT, GT, EQ;

always @(*) begin
        if (a > b) begin
            GT = 1'b1;
            LT = 1'b0;
            EQ = 1'b0;
        end else if (a < b) begin
            GT = 1'b0;
            LT = 1'b1;
            EQ = 1'b0;
        end else begin
            GT = 1'b0;
            LT = 1'b0;
            EQ = 1'b1;
        end
    end
endmodule
