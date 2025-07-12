`timescale 1ps/1ps
`include "pattern_detect.v"

// module pattern_detect_tb;

//     reg clk, x;
//     wire z;

//     pattern_detect uut (clk, x, z);

//     initial clk = 1'b0;
//     always #5 clk = ~clk;

//     // initial begin
//     //     $dumpfile ("sequence.vcd"); $dumpvars (0, pattern_detect_tb);
//     //     clk = 1'b0;
//     // end

//     initial begin

//         $monitor("Time = %t | x = %b | z = %b", $time, x, z);

//         #2 x = 0; #10 x = 0; #10 x = 1; #10 x = 1;
//         #10 x = 0; #10 x = 1; #10 x = 1; #10 x = 0;
//         #10 x = 0; #10 x = 1; #10 x = 1; #10 x = 0;

//         #10 $finish;
//     end
// endmodule



module pattern_detect_tb;

    reg clk, x, reset; 
    wire z;

pattern_detect SEQ (x, clk, reset, z);
    initial
    begin
// $dumpfile ("sequence.vcd"); $dumpvars (0, test_sequence);
        clk = 1'b0; 
        reset = 1'b1;
        #15 reset = 1'b0;
    end

    always #5 clk = ~clk;

    initial
    begin

    $monitor("Time = %t | clk = %b | x = %b | z = %b", $time, clk, x, z);
    #12 x = 0; #10 x = 0; #10 x = 1; #10 x = 1;
    #10 x = 0; #10 x = 1; #10 x = 1; #10 x = 0;
    #10 x = 0; #10 x = 1; #10 x = 1; #10 x = 0;
    #10 $finish;

    end
endmodule