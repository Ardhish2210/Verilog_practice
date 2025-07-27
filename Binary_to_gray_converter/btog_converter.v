module btog_converter (binary_num, gray_code);

input  [3:0] binary_num;
output reg [3:0] gray_code;

// Method-1
// assign gray_code = binary_num ^ (binary_num >> 1);

// Method-2
integer i;
always @(*) begin
    gray_code[3] = binary_num[3];
    for (i = 2; i >= 0; i = i - 1) begin
        gray_code[i] = binary_num[i+1] ^ binary_num[i];
    end
end

//Method-3

// assign gray_code[3] = binary_num[3];
// assign gray_code[2] = binary_num[3] ^ binary_num[2];
// assign gray_code[1] = binary_num[2] ^ binary_num[1];
// assign gray_code[0] = binary_num[1] ^ binary_num[0];

endmodule
