module elevator_fsm (clk, rst, up_request, current_floor, direction);

input clk;
input rst;
input up_request;
input [1:0] current_floor;
output reg [1:0] direction;
    
reg [1:0] state, next_state;
parameter IDLE = 2'b00, UP = 2'b01, DOWN = 2'b10, STAY = 2'b11;

always @(posedge clk or posedge rst) begin
    if (rst)
        state <= IDLE;
    else
        state <= next_state;
end

always @(*) begin
    case (state)
        IDLE: begin
            if ((current_floor == 2'b11) && (up_request == 1'b1))
                next_state = STAY;
            else if ((current_floor == 2'b00) && (up_request == 1'b0))
                next_state = STAY;
            else if (up_request)
                next_state = UP;
            else
                next_state = DOWN;
        end

        UP: begin
            if (current_floor == 2'b11)
                next_state = STAY;
            else if (!up_request)
                next_state = DOWN;  // switch if new down request
            else
                next_state = UP;
        end

        DOWN: begin
            if (current_floor == 2'b00)
                next_state = STAY;
            else if (up_request)
                next_state = UP;    // switch if new up request
            else
                next_state = DOWN;
        end
        
        STAY: begin
            if (up_request && current_floor != 2'b11)
                next_state = UP;
            else if (!up_request && current_floor != 2'b00)
                next_state = DOWN;
            else
                next_state = STAY;
        end

        default: next_state = IDLE;
    endcase
end

always @(*) begin
    case (state)
        IDLE:   direction = 2'b00; 
        UP:     direction = 2'b01;
        DOWN:   direction = 2'b10;
        STAY:   direction = 2'b00;
        default: direction = 2'b00;
    endcase
end

endmodule
