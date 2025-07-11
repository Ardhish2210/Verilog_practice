module FSM_evod (x, clk, z);

    input x;
    reg eve_odd;
    input clk;
    output reg z;
    parameter EVEN = 0, ODD = 1, S0 = 0, S1 = 1;

    always @(posedge clk) begin
        case (eve_odd)
        
            EVEN: begin
            z <= x ? 0:1;
            eve_odd <= x ? EVEN : ODD;
            end

            ODD: begin
            z <= x ? 1:0;
            eve_odd <= x ? ODD : EVEN;
            end

        default: eve_odd <= EVEN;
        endcase
    end

endmodule
