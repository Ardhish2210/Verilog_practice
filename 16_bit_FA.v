module full_adder_16bit (
    input [15:0] A,     // 16-bit input A
    input [15:0] B,     // 16-bit input B
    input Cin,          // Carry input
    output [15:0] Sum,  // 16-bit output Sum
    output Cout         // Carry output
);

    wire c4, c8, c12; // Internal carry signals between 4-bit adders
    // c4 = Carry[0], c8 = Carry[1], c12 = Carry[2]

    // Instantiate 4-bit full adders
    full_adder_4bit fa1 (.A(A[3:0]),   .B(B[3:0]),   .Cin(Cin),  .Sum(Sum[3:0]),   .Cout(c4));
    full_adder_4bit fa2 (.A(A[7:4]),   .B(B[7:4]),   .Cin(c4),   .Sum(Sum[7:4]),   .Cout(c8));
    full_adder_4bit fa3 (.A(A[11:8]),  .B(B[11:8]),  .Cin(c8),   .Sum(Sum[11:8]),  .Cout(c12));
    full_adder_4bit fa4 (.A(A[15:12]), .B(B[15:12]), .Cin(c12),  .Sum(Sum[15:12]), .Cout(Cout));

endmodule

// 4-bit Full Adder Module
module full_adder_4bit (
    input [3:0] A,       // 4-bit input A
    input [3:0] B,       // 4-bit input B
    input Cin,           // Carry input
    output [3:0] Sum,    // 4-bit output Sum
    output Cout          // Carry output
);

    wire [3:0] Carry; // Internal carry signals

    // Instantiate 1-bit full adders
    full_adder fa0 (.A(A[0]), .B(B[0]), .Cin(Cin),      .Sum(Sum[0]), .Cout(Carry[0]));
    full_adder fa1 (.A(A[1]), .B(B[1]), .Cin(Carry[0]), .Sum(Sum[1]), .Cout(Carry[1]));
    full_adder fa2 (.A(A[2]), .B(B[2]), .Cin(Carry[1]), .Sum(Sum[2]), .Cout(Carry[2]));
    full_adder fa3 (.A(A[3]), .B(B[3]), .Cin(Carry[2]), .Sum(Sum[3]), .Cout(Cout));

endmodule

// 1-bit Full Adder Module
module full_adder (
    input A,
    input B,
    input Cin,
    output Sum,
    output Cout
);

    // Full adder logic
    assign Sum = A ^ B ^ Cin;
    assign Cout = (A & B) | (Cin & (A ^ B));

endmodule
