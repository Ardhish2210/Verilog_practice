module full_subtractor (A, B, b_in, diff, b_out);

input A, B, b_in;
output diff, b_out;

assign diff = A ^ B ^ b_in;
assign b_out = (b_in & (A ^ (~B)))  | ((~A)&B);
    
endmodule