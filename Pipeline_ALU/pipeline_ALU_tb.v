`timescale 1ps/1ps
`include "pipeline_ALU.v"

module pipeline_ALU_tb; 

    reg [3:0] rs1, rs2, rd;
    reg clk1, clk2;
    reg [3:0] func;
    wire [3:0] Z;
    reg [7:0] addr;
    integer k;

    pipeline_ALU mypipe (rs1, rs2, rd, func, addr, clk1, clk2, Z);

    initial begin
        clk1 = 0; clk2 = 0;
        repeat(50) begin
            #5 clk1 = 1; #5 clk1 = 0;
            #5 clk2 = 1; #5 clk2 = 0;
        end
    end

    initial begin
        for(k = 0; k < 16; k = k + 1) begin
            mypipe.regbank[k] = k;
        end
    end

    initial begin
        #5  rs1 = 3;  rs2 = 5;  rd = 10; func = 0;  addr = 125; // ADD
        #20 rs1 = 3;  rs2 = 8;  rd = 12; func = 2;  addr = 126; // MUL
        #20 rs1 = 10; rs2 = 5;  rd = 14; func = 1;  addr = 128; // SUB
        #20 rs1 = 7;  rs2 = 3;  rd = 13; func = 11; addr = 127; // SLA
        #20 rs1 = 10; rs2 = 5;  rd = 15; func = 1;  addr = 129; // SUB
        #20 rs1 = 12; rs2 = 13; rd = 16; func = 0;  addr = 130; // ADD

        // Wait for pipeline to flush
        #100;

        // Print memory contents after write-back
        for(k = 125; k <= 130; k = k + 1) begin
            $display("Mem[%3d] = %d", k, mypipe.mem[k]);
        end
    end

    initial begin
        $monitor("Time: %3d, Z = %3d", $time, Z);
    end

    initial begin
        $dumpfile("pipeline_ALU.vcd");
        $dumpvars(0, pipeline_ALU_tb);
        #300 $finish;
    end
endmodule
