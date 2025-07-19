module pipeline_ALU (rs1, rs2, rd, func, addr, clk1, clk2, Z);

    input [3:0] rs1, rs2, rd;
    input clk1, clk2;
    input [3:0] func;
    output [3:0] Z;
    input [7:0] addr;

    reg [15:0] L12_A, L12_B, L23_Z, L34_Z;
    reg [3:0] L12_rd, L12_func, L23_rd;
    reg [7:0] L12_addr, L23_addr, L34_addr;

    reg [15:0] regbank [0:15]; //16 registers of 16 bits each (registerbank)
    reg [15:0] mem [0:255]; //256 words of 16 bits each
    assign Z = L34_Z;

    always @(posedge clk1) begin // L12
        L12_A <= #2 regbank[rs1];
        L12_B <= #2 regbank[rs2];
        L12_func <= #2 func;
        L12_addr <= #2 addr;
        L12_rd <= #2 rd;
    end
    
    always @(negedge clk2) begin // L23
        case (func)
            0: L23_Z <= #2 L12_A + L12_B;
            1: L23_Z <= #2 L12_A - L12_B;
            2: L23_Z <= #2 L12_A * L12_B;
            3: L23_Z <= #2 L12_A;
            4: L23_Z <= #2 L12_B;
            5: L23_Z <= #2 L12_A & L12_B;
            6: L23_Z <= #2 L12_A | L12_B;
            7: L23_Z <= #2 L12_A ^ L12_B;
            8: L23_Z <= #2 - L12_A;
            9: L23_Z <= #2 - L12_B;
            10: L23_Z <= #2 L12_A >> 1;
            11: L23_Z <= #2 L12_A << 1;
            default: L23_Z <= #2 16'hxxxx;
        endcase
            L23_addr <= #2 L12_addr;
            L23_rd <= #2 L12_rd;
    end

    always @(posedge clk1) begin // L34       
            regbank[L23_rd] <= #2 L23_Z;
            L34_Z <= #2 L23_Z;
            L34_addr <= #2 L23_addr; 
    end

    always @(negedge clk2) begin // L45
            mem[L34_addr] <= #2 L34_Z;           
    end

endmodule