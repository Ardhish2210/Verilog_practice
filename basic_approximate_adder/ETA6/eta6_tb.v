`timescale 1ns/1ps
`include "eta6.v"

// Exact 1-bit Full Adder definition for DUT's internal reference
// module full_adder(input a, input b, input cin, output sum, output cout);
//     assign {cout, sum} = a + b + cin;
// endmodule

module eta6_tb;

    reg [5:0] A, B;
    wire [5:0] SUM;
    wire COUT;

    // DUT instance
    eta6 uut (
        .A(A),
        .B(B),
        .SUM(SUM),
        .COUT(COUT)
    );

    integer total_cases = 0;
    integer error_count = 0;
    integer error_distance_sum = 0;

    integer exact_val, approx_val, err_dist;

    initial begin
        for (integer i = 0; i < 64; i = i + 1) begin
            for (integer j = 0; j < 64; j = j + 1) begin
                A = i;
                B = j;

                #1; // allow propagation

                // Exact 7-bit sum
                exact_val  = A + B; 
                // Approx value from DUT
                approx_val = {COUT, SUM};

                // Error distance
                err_dist = (exact_val > approx_val) ?
                           (exact_val - approx_val) :
                           (approx_val - exact_val);

                total_cases = total_cases + 1;
                if (err_dist != 0) begin
                    error_count = error_count + 1;
                    error_distance_sum = error_distance_sum + err_dist;
                end

                // Uncomment below to see each case
                // $display("A=%b B=%b | Exact=%07b Approx=%07b | ErrorDist=%0d",
                //          A, B, exact_val, approx_val, err_dist);
            end
        end

        $display("\nTotal Cases: %0d", total_cases);
        $display("Error Count: %0d", error_count);
        $display("Error Rate: %f%%", (error_count * 100.0) / total_cases);
        $display("Mean Error Distance (MED): %f", error_distance_sum * 1.0 / total_cases);

        $finish;
    end

endmodule
