// This is the code to detect '101' sequence
 
module seq_detect (clk, rst, in, out);

input clk, rst, in;
output reg out;

reg [1:0] state, next_state;
parameter S0 = 2'b00, S1 = 2'b01, S2 = 2'b10, S3 = 2'b11;

always @(posedge clk or posedge rst) begin
    if(rst) begin 
        state <= S0;
    end else begin
        state <= next_state;
    end
end

always @(*) begin
    out = 0;
    case (state)
    S0: next_state = in ? S1:S0;
    S1: next_state = in ? S1:S2;
    S2: next_state = in ? S3:S0;
    S3: begin
        next_state = in ? S1:S2;
        out <= 1'b1;
    end 
    default: begin
                next_state = S0;
                out = 1'b0;
            end
    endcase
end
    
endmodule
