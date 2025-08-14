module priority_encoder_new (d, out, valid);
    
input valid;
input [7:0] d;
output reg [2:0] out;
integer i;

always @(*) begin
    if(valid) begin
        for(i = 0; i < 8; i = i + 1) begin
            if(d[i] == 1'b1) begin
                out = i;
            end
        end
    end else begin
      out = 3'b000;
    end
end

endmodule