// The below written is the code for a digital lock which will open when the correct sequence 
// "1101" is entered

module digital_lock (clk, rst, in_seq, out);

input clk, rst;
input [3:0] in_seq;
output reg out;

reg [2:0] state, next_state;
parameter S0 = 3'b000, S1 = 3'b001, S2 = 3'b010, S3 = 3'b011, OPEN_STATE = 3'b100;

always @(posedge clk or posedge rst) begin
    if (rst) begin
        state <= S0;
    end else begin
        state <= next_state;
    end
end

always @(*) begin
    out = 0;
    case (state)

    S0: next_state <= (in_seq[0]) ? S1:S0;
    S1: next_state <= (in_seq[1]) ? S2:S0;
    S2: next_state <= (in_seq[2]) ? S0:S3;
    S3: next_state <= (in_seq[3]) ? OPEN_STATE:S0;
    OPEN_STATE: begin
        out <= 1;
        next_state <= S0;  
    end
        
        default: begin
            next_state <= S0;
        end
    endcase
end
    
endmodule