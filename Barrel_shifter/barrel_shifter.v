module barrel_shifter (a, sel, N, out);

input [3:0] a;
input [1:0] sel;
input [1:0] N; //Number of bits the use needs to shift
output reg [3:0] out;

always @(*) begin
    case (sel)
    2'b00: begin // Rotate left by 1
      out = a[3] | (a << N);
    end
    2'b01: begin // Rotate right by 1
      out = (a >> N) | (a[0] << 3);
    end
    2'b10: begin // logical shift left
      out = a << N;
    end
    2'b11: begin // logical shift right
      out = a >> N;
    end
    endcase
end

endmodule
