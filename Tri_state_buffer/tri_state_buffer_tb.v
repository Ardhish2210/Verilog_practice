module tri_state_buffer_tb;

reg [1:0] sel;
reg enable;
reg [3:0] a;
wire bus_line;

tri_state_buffer uut (sel, enable, a, bus_line);

initial begin

    $dumpfile("tri_state_buffer.vcd");
    $dumpvars(0, tri_state_buffer_tb);

    $monitor("enable: %0b || sel: %0d || a: %04b || bus_line: %0b", enable, sel, a, bus_line);

    enable = 1'b1;
    sel = 2'b00;
    a = 4'b0000;

    #10 sel = 2'b00; a = 4'b1010;
    #10 sel = 2'b01; a = 4'b1010;
    #10 sel = 2'b10; a = 4'b1010;
    #10 sel = 2'b11; a = 4'b1010;

    #10 $finish;

end


endmodule