// This is the code to detect '0111' sequence
 
module sequence_dct (clk, rst, in, out);

input clk, rst, in;
output reg out;

reg [2:0] state, next_state;
parameter S0 = 3'b000, S1 = 3'b001, S2 = 3'b010, S3 = 3'b011, S4 = 3'b100;

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
    S0: next_state = in ? S0:S1;
    S1: next_state = in ? S2:S1;
    S2: next_state = in ? S3:S1;
    S3: next_state = in ? S4:S1;
    S4: begin
        next_state = in ? S0:S1;
        out = 1'b1;
    end 
    default: begin
                next_state = S0;
                out = 1'b0;
            end
    endcase
end
    
endmodule
