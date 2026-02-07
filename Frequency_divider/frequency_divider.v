module freq_divider (clk, rst, clk_out);
    
    parameter N = 4;
    input clk, rst;
    output reg clk_out;
    reg [1:0]count;

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            count <= 0;
            clk_out <= 0;
        end else if (count == N-1) begin
            count <= 0;
            clk_out <= ~clk_out;
        end else begin
            count <= count + 1;
        end
    end
endmodule
