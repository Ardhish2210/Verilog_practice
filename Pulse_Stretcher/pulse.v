module pulse (clk, rst, in_pulse, out_pulse);

parameter stretch_length = 8;
input clk, rst, in_pulse;
output reg out_pulse;
reg [3:0] counter;

always @(posedge clk or posedge rst) begin
    if (rst) begin
        out_pulse <= 1'b0;
        counter <= 0;
    end else begin
        if (in_pulse) begin
            out_pulse <= 1'b1;
            counter <= stretch_length;
        end else if (counter != 0) begin
            out_pulse <= 1'b1;
            counter <= counter + 1;
        end else begin
            out_pulse <= 1'b0;  
        end
    end
end
    
endmodule