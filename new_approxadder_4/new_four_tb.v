`timescale 1ns/1ns
`include "new_four.v"

module new_four_tb;

reg [31:0] a, b;
wire [32:0] sum;
wire [32:0] approx_sum;
reg [32:0] exact_sum;

wire cout;

new_four uut (.a(a), .b(b), .sum(approx_sum));

integer i, j;
integer total_cases;
integer error_count;
integer error_val;
integer abs_error;

real AE, MAE, MSE, RMSE, MEP;
real error_sum, abs_error_sum, sq_error_sum;

initial begin 

    error_count = 0;
    error_sum = 0;
    abs_error_sum = 0;
    sq_error_sum = 0;
    total_cases = 0;

    for (i = 0; i < 256; i = i + 1) begin
        for (j = 0; j < 256; j = j + 1) begin
            a = i; b = i;
            #1;

            exact_sum = a + b;
            error_val = approx_sum - exact_sum;
            abs_error = (error_val < 0) ? -error_val : error_val;

            if (error_val != 0) begin
                error_count++;
            end

            error_sum     = error_sum + error_val;
                abs_error_sum = abs_error_sum + abs_error;
                sq_error_sum  = sq_error_sum + (error_val * error_val);
                total_cases++;
        end
    end

    AE = error_sum / total_cases;
    MAE = abs_error_sum / total_cases;
    MSE = sq_error_sum / total_cases;
    RMSE = $sqrt(MSE);
    MEP = (MAE / 510.0)*100; // Normalised wrt to the max sum 255 + 255 = 510

    $display("SCSA approximate adder error metrices");
    $display("Total test cases = %0d", total_cases);
    $display("Error Rate (ER) = %0.4f %%", (error_count*100)/total_cases);
    $display("Average Error (AE) = %0.4f", AE);
    $display("Mean Abs Error (MAE) = %0.4f", MAE);
    $display("Mean Square Error (MSE) = %0.4f", MSE);
    $display("Root Mean Square Error (RMSE) = %0.4f", RMSE);
    $display("Mean Error Percentage (MEP) = %0.4f %%", MSE);

    $finish;

end

endmodule