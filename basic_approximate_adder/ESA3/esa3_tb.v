`timescale 1ns/1ps
`include "esa3.v"

module esa3_tb;

    reg [7:0] a, b;
    wire [8:0] approx_sum;
    reg [8:0] exact_sum;
    integer total_cases = 0;
    integer error_count = 0;
    integer error_distance_sum = 0;
    integer err_dist;

    // Instantiate DUT
    esa3 uut (
        .a(a),
        .b(b),
        .sum(approx_sum)
    );

    initial begin
        // Exhaustive testing for all 8-bit values of a and b
        for (integer i = 0; i < 256; i = i + 1) begin
            for (integer j = 0; j < 256; j = j + 1) begin
                a = i;
                b = j;
                #1; // small delay for simulation update

                exact_sum = a + b;

                err_dist = (exact_sum > approx_sum) ? 
                           (exact_sum - approx_sum) : 
                           (approx_sum - exact_sum);

                total_cases = total_cases + 1;

                if (err_dist != 0) begin
                    error_count = error_count + 1;
                    error_distance_sum = error_distance_sum + err_dist;
                end
            end
        end

        // Print results
        $display("Total Cases: %0d", total_cases);
        $display("Error Count: %0d", error_count);
        $display("Error Rate: %f%%", (error_count * 100.0) / total_cases);
        $display("Mean Error Distance (MED): %f", error_distance_sum * 1.0 / total_cases);

        $finish;
    end

endmodule
