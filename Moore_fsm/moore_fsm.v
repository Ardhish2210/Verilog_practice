module moore_fsm (clk, rst, in, out);

input clk;       
input rst;       
input in;       
output reg out;   

parameter IDLE = 1'b0;
parameter ACTIVE = 1'b1;

    reg state;  
  
    always @(posedge clk or posedge rst) begin
        if (rst)
            state <= IDLE;            
        else if (state == IDLE && in)
            state <= ACTIVE;          
        else
            state <= state;          
    end

    always @(*) begin
        if (state == IDLE)
            out = 0;
        else
            out = 1;
    end

endmodule
