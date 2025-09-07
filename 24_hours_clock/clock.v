module clock (clk, rst, hours, minutes, seconds);

input clk, rst;
output reg [4:0] hours; 
output reg [5:0] minutes;
output reg [5:0] seconds;

reg [12:0] count; // Because we r using a clock with frequency 5Khz, hence TimePeriod = 0.2ms and for seconds flag to be 1, 0.2 * 5000 = 1sec.

always @(posedge clk or posedge rst) begin
    if (rst) begin
        count   <= 0;
        seconds <= 0;
        minutes <= 0;
        hours   <= 0;
    end else begin
        if (count == 4999) begin
            count <= 0;
            if (seconds == 59) begin
                seconds <= 0;
                if (minutes == 59) begin
                    minutes <= 0;
                    if (hours == 23)
                        hours <= 0;
                    else
                        hours <= hours + 1;
                end else begin
                    minutes <= minutes + 1;
                end
            end else begin
                seconds <= seconds + 1;
            end
        end else begin
            count <= count + 1;
        end
    end
end
endmodule
