module clock (clk, rst, hours, minutes, seconds);

input clk, rst;
output reg hours, minutes, seconds;

integer count = 4999; // Because we r using a clock with frequency 5Khz, hence TimePeriod = 0.2ms and for seconds flag to be 1, 0.2 * 5000 = 1sec.
integer i, j, k;

always @(posedge clk) begin
    if (rst) begin
        hours = 1'b0;
        minutes = 1'b0;
        seconds = 1'b0;
    end else begin
        for (i = 0; i <= count; i = i + 1) begin
            seconds = 1'b1;
            for (j = 0; j <= 59; j = j + 1) begin
                minutes = 1'b1;
                for (k = 0; k <= 59; k = k + 1) begin
                    hours = 1'b1;
                end
            end
        end
    end
end
endmodule