module full_adder_16bit (
    input [15:0] A,     
    input [15:0] B,     
    input Cin,          
    output [15:0] Sum,  
    output Cout         
);

    wire c4, c8, c12; 
    // c4 = Carry[0], c8 = Carry[1], c12 = Carry[2]

    full_adder_4bit fa1 (.A(A[3:0]),   .B(B[3:0]),   .Cin(Cin),  .Sum(Sum[3:0]),   .Cout(c4));
    full_adder_4bit fa2 (.A(A[7:4]),   .B(B[7:4]),   .Cin(c4),   .Sum(Sum[7:4]),   .Cout(c8));
    full_adder_4bit fa3 (.A(A[11:8]),  .B(B[11:8]),  .Cin(c8),   .Sum(Sum[11:8]),  .Cout(c12));
    full_adder_4bit fa4 (.A(A[15:12]), .B(B[15:12]), .Cin(c12),  .Sum(Sum[15:12]), .Cout(Cout));

endmodule

// 4-bit Full Adder Module
module full_adder_4bit (
    input [3:0] A,       
    input [3:0] B,      
    input Cin,           
    output [3:0] Sum,    
    output Cout          
);

    wire [3:0] Carry; 

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

    assign Sum = A ^ B ^ Cin;
    assign Cout = (A & B) | (Cin & (A ^ B));

endmodule
