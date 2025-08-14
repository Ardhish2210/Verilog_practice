module tri_state_buffer (sel, enable, a, bus_line);

input [1:0] sel;
input enable;
input [3:0] a;
output reg bus_line;

reg [3:0] d;

always @(*) begin
    if (enable) begin
        case (sel)
        2'b00: begin
            d[0] = 1'b1;
            bus_line = a[0];
        end
        2'b01: begin
            d[1] = 1'b1;
            bus_line = a[1];
        end
        2'b10: begin
            d[2] = 1'b1;
            bus_line = a[2];
        end
        2'b11: begin
            d[3] = 1'b1;
            bus_line = a[3];
        end
        endcase
    end 
end

endmodule