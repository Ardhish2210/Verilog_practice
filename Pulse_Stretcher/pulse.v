module pulse (clk, rst, in_pulse, out_pulse);

input clk, rst, in_pulse;
output reg out_pulse;

always @(posedge clk or posedge rst) begin
    if (rst) begin
        out_pulse <= 1'b0;
    end else begin
        out_pulse <= in_pulse;
    end
end
    
endmodule