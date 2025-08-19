# 🔷 Verilog HDL & RTL Design Interview Questions (26-30)
---

## Question 26: How will you avoid latch inference in conditional code?

### 🔴 My Answer:
Let us consider a condition of a combination always block in which there is an "If-else" condition written.

IN THE BELOW WRITTEN CODE THERE WILL BE LATCH INFERRED

```verilog
module trail (a,out);

always @(*) begin
  if (a = 1'b1) out = 1'b0;
end

endmodule
```

TO AVOID LATCH IN IF ELSE STATEMENT ALWAYS WRITE "ELSE" CONDITION AS WELL.

```verilog
module trail (a,out);

always @(*) begin
  if (a = 1'b1) begin
    out = 1'b0;
  end else begin
    out = 1'b1;
  end
endmodule
```

In case of "case" statements always write the default statement as well, otherwise there are chance of latch creation.

### 🟢 Correct Answer:

Latch inference occurs when synthesis tools cannot determine a signal's value under all conditions.

**Prevention Methods:**

**1. Complete if-else statements:**
```verilog
// PROBLEMATIC: Latch inferred
always @(*) begin
    if (enable)
        output_reg = input_data;  // Missing else
end

// SOLUTION: Complete if-else
always @(*) begin
    if (enable)
        output_reg = input_data;
    else
        output_reg = 1'b0;
end
```

**2. Default assignments:**
```verilog
always @(*) begin
    output_reg = 1'b0;  // Default value
    if (condition1)
        output_reg = value1;
    else if (condition2)
        output_reg = value2;
end
```

**3. Complete case statements:**
```verilog
always @(*) begin
    case (select)
        2'b00: out = in0;
        2'b01: out = in1;
        2'b10: out = in2;
        2'b11: out = in3;
        default: out = 1'b0;  // Always include default
    endcase
end
```

---

## Question 28: Design a binary up-down counter in Verilog with enable.

### 🔴 My Answer:
```verilog
module binary_counter (
input clk,
input rst,
input en,
output reg [3:0] counter
);

always @(posedge clk or posedge rst) begin
if (rst) begin
counter <= 4'b0000;
end
else if (en) begin
if (counter == 4'b1001)
counter <= 4'b0000;
else
counter <= counter + 1;
end
end

endmodule
```

### 🟢 Correct Answer:

**Basic Up-Down Counter:**
```verilog
module up_down_counter #(parameter WIDTH = 4) (
    input clk,
    input reset,
    input enable,
    input up_down,  // 1=up, 0=down
    output reg [WIDTH-1:0] count
);

always @(posedge clk or posedge reset) begin
    if (reset) begin
        count <= 0;
    end else if (enable) begin
        if (up_down)
            count <= count + 1;  // Count up
        else
            count <= count - 1;  // Count down
    end
end

endmodule
```

**With Overflow/Underflow Detection:**
```verilog
module up_down_counter_enhanced (
    input clk, reset, enable, up_down,
    output reg [3:0] count,
    output overflow, underflow
);

always @(posedge clk or posedge reset) begin
    if (reset)
        count <= 4'b0000;
    else if (enable) begin
        if (up_down && count != 4'b1111)
            count <= count + 1;
        else if (!up_down && count != 4'b0000)
            count <= count - 1;
    end
end

assign overflow = enable && up_down && (count == 4'b1111);
assign underflow = enable && !up_down && (count == 4'b0000);

endmodule
```

---

## Question 29: How to declare a memory array in Verilog and initialize it?

### 🔴 My Answer:
reg [3:0] mem [257:0]

The above statement will create an "MEM", in which each variable will be there of 4 bit and 256 such variables will be there from 0 to 255, this is how we can Initialise and declare a memory in Verilog

### 🟢 Correct Answer:

**Declaration Syntax:**
```verilog
reg [width-1:0] memory_name [depth-1:0];

// Examples:
reg [7:0] memory [0:255];    // 256 locations × 8 bits
reg [15:0] ram [0:1023];     // 1024 locations × 16 bits
```

**Initialization Methods:**

**1. Individual Assignment:**
```verilog
initial begin
    memory[0] = 8'h00;
    memory[1] = 8'hFF;
    memory[2] = 8'hAA;
end
```

**2. Loop Initialization:**
```verilog
integer i;
initial begin
    for (i = 0; i < 256; i = i + 1) begin
        memory[i] = i;  // Initialize with address values
    end
end
```

**3. File Loading:**
```verilog
initial begin
    $readmemh("data.hex", memory);  // Load from hex file
    $readmemb("data.bin", memory);  // Load from binary file
end
```

**Complete Example:**
```verilog
module memory_module (
    input clk, write_en,
    input [7:0] addr, data_in,
    output reg [7:0] data_out
);

reg [7:0] mem [0:255];

// Initialize memory
initial begin
    $readmemh("init.hex", mem);
end

// Memory operations
always @(posedge clk) begin
    if (write_en)
        mem[addr] <= data_in;
    data_out <= mem[addr];
end

endmodule
```

---

## Question 30: Write a Verilog code to find parity of 8-bit data.

### 🔴 My Answer:
```verilog
module parity_generator (in, out);

input [7:0] in;
output reg out;
integer i;
integer count;

always @(*) begin
count = 0;
for(i = 0; i < 7; i = i + 1) begin
if(in[i] == 1)
count = count + 1;
end

if(count % 2 == 0)
out = 1;
else
out = 0;
end
endmodule
```

### 🟢 Correct Answer:

**Method 1: XOR Reduction (Simplest):**
```verilog
module parity_simple (
    input [7:0] data,
    output even_parity,
    output odd_parity
);

assign odd_parity = ^data;     // XOR all bits
assign even_parity = ~^data;   // XNOR all bits

endmodule
```

**Method 2: Procedural Implementation:**
```verilog
module parity_procedural (
    input [7:0] data,
    output reg parity
);

integer i;

always @(*) begin
    parity = 1'b0;
    for (i = 0; i < 8; i = i + 1) begin
        parity = parity ^ data[i];
    end
end

endmodule
```

**Method 3: Parameterized Version:**
```verilog
module parity_generator #(parameter WIDTH = 8) (
    input [WIDTH-1:0] data,
    output odd_parity,
    output even_parity,
    output [WIDTH:0] data_with_parity
);

assign odd_parity = ^data;
assign even_parity = ~odd_parity;
assign data_with_parity = {even_parity, data};

endmodule
```

**Testbench:**
```verilog
module parity_tb;

reg [7:0] data;
wire even_parity, odd_parity;

parity_simple dut (data, even_parity, odd_parity);

initial begin
    data = 8'b00000000; #1; $display("%b | Even:%b Odd:%b", data, even_parity, odd_parity);
    data = 8'b10000000; #1; $display("%b | Even:%b Odd:%b", data, even_parity, odd_parity);
    data = 8'b11111111; #1; $display("%b | Even:%b Odd:%b", data, even_parity, odd_parity);
    $finish;
end

endmodule
```

---

### 📝 **Legend:**
- 🔴 **My Answer** - Initial response  
- 🟢 **Correct Answer** - Accurate technical solution
- 🔷 **Key Points** - Important concepts to remember
