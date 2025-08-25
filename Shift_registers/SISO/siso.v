module siso (clk, rst, sin, sout);

input alk, rst, sin;
output sout; 

reg [3:0] shift_reg;

always@ (posedge clk or posedge rst) begin
    if (rst) begin
        shift_reg <= 4'b0000;
    end else begin
        shift_reg <= {shift_reg[2:0], sin};      
    end
end

assign sout = shift_reg[3];

endmodule