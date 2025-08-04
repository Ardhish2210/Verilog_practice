module sram (clk, w_enable, addr, data_in, data_out);

input clk;
input w_enable;
input [7:0] addr, data_in;
output [7:0] data_out;

// memory declared
reg [7:0] mem [0: 255];

always @(posedge clk) begin
    
endmodule