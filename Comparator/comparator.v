module comparator(a, b, LT, GT, EQ);
    
input [3:0] a, b;
output reg LT, GT, EQ;
integer i;

always @(*) begin
    for (i=0; i<4; i=i+1) begin
        if (a[i] > b[i]) begin
            GT = 1'b1;
            LT = 1'b0;
            EQ = 1'b0;
        end else if (a[i] < b[i]) begin
            GT = 1'b0;
            LT = 1'b1;
            EQ = 1'b0;
        end
    end
  
    if(a == b) begin
        GT = 1'b0;
        LT = 1'b0;
        EQ = 1'b1;
    end
end
endmodule
