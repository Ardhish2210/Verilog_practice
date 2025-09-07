module parity_generator (in, out);

    input [3:0] in;
    output reg out;
    integer i;
    integer count;

    //method-01
    assign out = ^(in); // out = 1 for EVEN parity, out = 0 for ODD parity

    //Method-02
    always @(*) begin
        count = 0;  
        for(i = 0; i < 4; i = i + 1) begin
            if(in[i] == 1)
                count = count + 1;
        end

        // Even parity: out = 1 if even number of 1s
        if(count % 2 == 0)
            out = 1;
        else
            out = 0;
    end
endmodule
