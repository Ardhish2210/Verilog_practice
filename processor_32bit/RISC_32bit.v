module RISC_32bit (input clk1, clk2);

    reg [31:0] PC, IF_ID_IR, IF_ID_NPC;
    reg [31:0] ID_EX_IR, ID_EX_NPC, ID_EX_A, ID_EX_B, ID_EX_Imm;
    reg [2:0] ID_EX_type, EX_MEM_type, MEM_WB_type;
    reg [31:0] EX_MEM_IR, EX_MEM_ALUOut, EX_MEM_B;
    reg EX_MEM_cond;
    reg [31:0] MEM_WB_IR, MEM_WB_ALUOut, MEM_WB_LMD;

    reg [31:0] Reg [0:31]; // Register bank (32 x 32)
    reg [31:0] Mem [0:1023]; // 1024 x 32 memory

    parameter ADD = 6'b000000, SUB = 6'b000001, AND = 6'b000010, OR = 6'b000011,
              SLT = 6'b000100, MUL = 6'b000101, HLT = 6'b111111, LW = 6'b001000,
              SW = 6'b001001, ADDI = 6'b001010, SUBI = 6'b001011, SLTI = 6'b001100,
              BNEQZ = 6'b001101, BEQZ = 6'b001110;

    parameter RR_ALU = 3'b000, RM_ALU = 3'b001, LOAD = 3'b010, STORE = 3'b011,
              BRANCH = 3'b100, HALT = 3'b101;

    reg Halted; 
    reg taken_branch; 

    // IF stage
    always @(posedge clk1) begin
        if (!Halted) begin
            if (((EX_MEM_IR[31:26] == BEQZ) && EX_MEM_cond) ||
                ((EX_MEM_IR[31:26] == BNEQZ) && !EX_MEM_cond)) begin
                taken_branch <= 1;
                IF_ID_IR <= Mem[EX_MEM_ALUOut];
                IF_ID_NPC <= EX_MEM_ALUOut + 1;
                PC <= EX_MEM_ALUOut + 1;
            end else begin
                IF_ID_IR <= Mem[PC];
                IF_ID_NPC <= PC + 1;
                PC <= PC + 1;
            end
        end
    end

    // ID stage
    always @(posedge clk2) begin
        if (!Halted) begin
            ID_EX_A <= (IF_ID_IR[25:21] == 5'b00000) ? 0 : Reg[IF_ID_IR[25:21]]; // rs
            ID_EX_B <= (IF_ID_IR[20:16] == 5'b00000) ? 0 : Reg[IF_ID_IR[20:16]]; // rt
            ID_EX_NPC <= IF_ID_NPC;
            ID_EX_IR <= IF_ID_IR;
            ID_EX_Imm <= {{16{IF_ID_IR[15]}}, IF_ID_IR[15:0]}; // Sign extension

            case (IF_ID_IR[31:26])
                ADD, SUB, AND, OR, SLT, MUL: ID_EX_type <= RR_ALU;
                ADDI, SUBI, SLTI: ID_EX_type <= RM_ALU;
                LW: ID_EX_type <= LOAD;
                SW: ID_EX_type <= STORE;
                BNEQZ, BEQZ: ID_EX_type <= BRANCH;
                HLT: ID_EX_type <= HALT;
                default: ID_EX_type <= HALT;
            endcase
        end
    end

    // EX stage
    always @(posedge clk1) begin
        if (!Halted) begin
            EX_MEM_type <= ID_EX_type;
            EX_MEM_IR <= ID_EX_IR;
            taken_branch <= 0;

            case (ID_EX_type)
                RR_ALU: begin
                    case (ID_EX_IR[31:26])
                        ADD: EX_MEM_ALUOut <= ID_EX_A + ID_EX_B;
                        SUB: EX_MEM_ALUOut <= ID_EX_A - ID_EX_B;
                        AND: EX_MEM_ALUOut <= ID_EX_A & ID_EX_B;
                        OR: EX_MEM_ALUOut <= ID_EX_A | ID_EX_B;
                        SLT: EX_MEM_ALUOut <= (ID_EX_A < ID_EX_B) ? 1 : 0;
                        MUL: EX_MEM_ALUOut <= ID_EX_A * ID_EX_B;
                        default: EX_MEM_ALUOut <= 32'h0;
                    endcase
                end
                RM_ALU: begin
                    case (ID_EX_IR[31:26])
                        ADDI: EX_MEM_ALUOut <= ID_EX_A + ID_EX_Imm;
                        SUBI: EX_MEM_ALUOut <= ID_EX_A - ID_EX_Imm;
                        SLTI: EX_MEM_ALUOut <= (ID_EX_A < ID_EX_Imm) ? 1 : 0;
                        default: EX_MEM_ALUOut <= 32'h0;
                    endcase
                end
                LOAD, STORE: begin
                    EX_MEM_ALUOut <= ID_EX_A + ID_EX_Imm;
                    EX_MEM_B <= ID_EX_B;
                end
                BRANCH: begin
                    EX_MEM_ALUOut <= ID_EX_NPC + ID_EX_Imm;
                    EX_MEM_cond <= (ID_EX_A == 0);
                end
            endcase
        end
    end

    // MEM stage
    always @(posedge clk2) begin
        if (!Halted) begin
            MEM_WB_type <= EX_MEM_type;
            MEM_WB_IR <= EX_MEM_IR;

            case (EX_MEM_type)
                RR_ALU, RM_ALU: MEM_WB_ALUOut <= EX_MEM_ALUOut;
                LOAD: MEM_WB_LMD <= Mem[EX_MEM_ALUOut];
                STORE: if (!taken_branch) Mem[EX_MEM_ALUOut] <= EX_MEM_B;
            endcase
        end
    end

    // WB stage
    always @(posedge clk1) begin
        case (MEM_WB_type)
            RR_ALU: Reg[MEM_WB_IR[15:11]] <= MEM_WB_ALUOut;
            RM_ALU: Reg[MEM_WB_IR[20:16]] <= MEM_WB_ALUOut;
            LOAD: Reg[MEM_WB_IR[20:16]] <= MEM_WB_LMD;
            HALT: Halted <= 1'b1;
        endcase
    end
endmodule
