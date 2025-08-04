module carry_save_adder (A, B, C, SUM, COUT);

input [3:0] A, B, C;
output [3:0] SUM, COUT;

full_adder F1 (.a(), .b(), .cin(), .sum(), .cout());
full_adder F2 (.a(), .b(), .cin(), .sum(), .cout());
full_adder F3 (.a(), .b(), .cin(), .sum(), .cout());
full_adder F4 (.a(), .b(), .cin(), .sum(), .cout());
    
endmodule   