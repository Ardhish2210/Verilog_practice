module FSM (clk, light);

input clk;
output reg [0:2] light;
parameter RED = 3'b000, GREEN = 3'b010, YELLOW = 3'b001;
parameter S0 = 0, S1 = 1, S2 = 2;
reg [1:0] state;

    always @(posedge clk) begin
        case (state)
            S0: begin               // RED light
                light <= GREEN; 
                state <= S1;
            end

            S1: begin               // GREEN light
                light <= YELLOW; 
                state <= S2;
            end

            S1: begin               // YELLOW light
                light <= RED; 
                state <= S0;
            end
            
        default: begin 
                light <= RED; 
                state <= S0;
        end            
        endcase
    end    
endmodule
