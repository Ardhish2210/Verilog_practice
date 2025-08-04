module sram (clk, w_enable, addr, data_in, data_out);

input clk;
input w_enable; // write enable
input [7:0] addr, data_in;
output reg [7:0] data_out;

// memory declared
reg [7:0] mem [0: 255];

always @(posedge clk) begin
    if(w_enable == 1'b1) begin
        mem[addr] <= data_in; 
    end 
    else begin
        data_out <= mem[addr];
    end
end
    
endmodule