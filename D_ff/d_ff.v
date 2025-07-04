module d_ff (q, clk, d, rst);

    output reg q;
    input clk;
    input d;
    input rst;

    always @(posedge clk or posedge rst) begin
        if (rst)
            q <= 1'b0;       
        else
            q <= d;         
    end
endmodule
