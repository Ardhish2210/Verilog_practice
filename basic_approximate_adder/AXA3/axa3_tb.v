module axa3_tb; 

reg a, b, cin;
wire sum, cout;

axa3 uut (a, b, cin, sum, cout);

initial begin 
    $dumpfile("axa3.vcd");
    $dumpvars(0, axa3_tb);

    $monitor("Time: %0t || a: %0b || b: %0b || cin: %0b || sum: %0b || cout: %0b", $time, a, b, cin, sum, cout);

    a = 0;
    b = 0;
    cin = 0;

    #10 a = 0; b = 0; cin = 0;
    #10 a = 0; b = 0; cin = 1;
    #10 a = 0; b = 1; cin = 0;
    #10 a = 1; b = 1; cin = 0;
    #10 a = 1; b = 0; cin = 0;

    #10 $finish;

end
    
endmodule