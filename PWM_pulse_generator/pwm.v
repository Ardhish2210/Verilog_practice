module pwm (clk, rst, duty_cycle, pwm_out);

input clk, rst;
input [7:0] duty_cycle;
output pwm_out;

reg [7:0] counter;

always @(posedge clk or posedge rst) begin
    if (rst) begin
        counter <= 8'b0000_0000;
    end else begin
        counter <= counter + 1;  
    end
end

assign pwm_out = (counter < duty_cycle) ? 1'b1:1'b0;
    
endmodule