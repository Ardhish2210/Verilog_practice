module axa3_tb; 

reg a, b, cin;
wire sum, cout;

axa3 uut (a, b, cin, sum, cout);

initial begin 
    $dumpfile("axa3.vcd");
    $dumpvars(0, axa3_tb);
end
    
endmodule