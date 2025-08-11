`timescale 1ns/1ps
`include "ama2.v"

module ama2_tb;

    reg a, b, cin;
    wire sum, cout;

    // DUT instance
    ama2 uut (
        .a(a),
        .b(b),
        .cin(cin),
        .sum(sum),
        .cout(cout)
    );

    integer total_cases = 0;
    integer error_count = 0;
    integer error_distance_sum = 0;

    
    reg exact_sum, exact_cout;
    integer exact_val, approx_val, err_dist;

    initial begin
        
        for (integer i = 0; i < 8; i = i + 1) begin
            {a, b, cin} = i[2:0];
            
            #1; 
            
            
            exact_sum  = a ^ b ^ cin;
            exact_cout = (a & b) | (b & cin) | (a & cin);

            exact_val  = {exact_cout, exact_sum}; // 2-bit value
            approx_val = {cout, sum};

            err_dist = (exact_val > approx_val) ? (exact_val - approx_val) : (approx_val - exact_val);

            total_cases = total_cases + 1;
            if (err_dist != 0) begin
                error_count = error_count + 1;
                error_distance_sum = error_distance_sum + err_dist;
            end

            $display("a=%b b=%b cin=%b | Exact=%b%b Approx=%b%b | ErrorDist=%0d",
                     a, b, cin, exact_cout, exact_sum, cout, sum, err_dist);
        end

        $display("\nTotal Cases: %0d", total_cases);
        $display("Error Count: %0d", error_count);
        $display("Error Rate: %f%%", (error_count * 100.0) / total_cases);
        $display("Mean Error Distance (MED): %f", error_distance_sum * 1.0 / total_cases);

        $finish;
    end

endmodule
