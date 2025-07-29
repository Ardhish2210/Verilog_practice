module counter_ten (clk, rst, counter);

input clk, rst;
output [3:0] counter;

always @(posedge clk or posedge rst) begin
    if(rst) begin
        counter <= 4'b0000;
    end else if (counter == 4'b1001) begin
        
    end

end


    
endmodule