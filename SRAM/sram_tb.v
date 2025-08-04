module sram_tb; 

reg clk;
reg w_enable; 
reg [7:0] addr, data_in;
wire [7:0] data_out;

sram uut (clk, w_enable, addr, data_in, data_out);

initial begin 
    $dumpfile("sram.vcd");
    $dumpvars(0, sram_tb);
end
    
endmodule