module encoder (a, enable, out);

input [2:0] a;
input enable;
output reg [7:0] out;

always@(*) begin

    if(!enable) begin
        out = 3'b000;
    end else begin
    case(a) 
    3'b000: out = 8'b0000_0001;
    3'b001: out = 8'b0000_0010;
    3'b010: out = 8'b0000_0100;
    3'b011: out = 8'b0000_1000;
    3'b100: out = 8'b0001_0000;
    3'b101: out = 8'b0010_0000;
    3'b110: out = 8'b0100_0000;
    3'b111: out = 8'b1000_0000;
    endcase
    end

end
endmodule