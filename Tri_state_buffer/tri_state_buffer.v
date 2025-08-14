module (sel, enable, a, bus_line);

input [1:0] sel;
input enable;
input [3:0] a;
output bus_line;

wire [3:0] d;

always @(*) begin
    if (enable) begin
        case (sel)
        2'b00: d[0] = 1'b1;
        2'b01: d[1] = 1'b1;
        2'b10: d[2] = 1'b1;
        2'b11: d[3] = 1'b1;
        endcase
    end 
end

endmodule