# 🔷 Verilog HDL & RTL Design Interview Questions (41-45)
---

## Question 41: Write Verilog code for Gray to Binary converter.

### 🔴 My Answer:
```verilog
module btog_converter (binary_num, gray_num);

input [3:0] binary_num;
output [3:0] gray_num;

assign gray_num[3] = binary_num[3];
assign gray_num[2] = binary_num[3] ^ binary_num[2];
assign gray_num[1] = binary_num[2] ^ binary_num[1];
assign gray_num[0] = binary_num[1] ^ binary_num[0];

endmodule
```

### 🟢 Correct Answer:

**Note:** The question asks for Gray to Binary, but your code shows Binary to Gray. Here's the correct Gray to Binary converter:

```verilog
module gray_to_binary (
    input [3:0] gray,
    output [3:0] binary
);

assign binary[3] = gray[3];
assign binary[2] = binary[3] ^ gray[2];
assign binary[1] = binary[2] ^ gray[1];
assign binary[0] = binary[1] ^ gray[0];

endmodule
```

**Key Difference:**
- **Gray → Binary:** MSB same, then XOR previous binary bit with current gray bit
- **Binary → Gray:** MSB same, then XOR current and next binary bits

---

## Question 42: What are logic levels in Verilog? Explain 0,1,x,z and their behavior.

### 🔴 My Answer:
Verilog follows the 4 level logics, which include 0, 1, x and z.

0, 1: These are the normal binary signals that are used in Verilog, if a signal is having value 1 then it is HIGH and similarly a signal with 0 value is said to be LOW.
x: This is another form of logical behaviour that is used in Verilog, If a variable is showing a value "x" it symbolises that the value is UNDEFINED for that time period.
z: It stands for HIGH IMPEDENCE

### 🟢 Correct Answer:

**Four-Value Logic System:**

| Value | Name | Description | Behavior |
|-------|------|-------------|----------|
| **0** | Logic 0 | Low/False | Strong drive to 0V |
| **1** | Logic 1 | High/True | Strong drive to VDD |
| **x** | Unknown | Undefined/Don't care | Unknown state, simulation pessimistic |
| **z** | High-Z | Tri-state/Floating | No drive, high impedance |

**Key Behaviors:**
```verilog
wire a = 1'bx;      // Unknown - could be 0 or 1
wire b = 1'bz;      // High impedance - floating
wire c = a & 1'b1;  // Result: x (unknown)
wire d;             // Uninitialized = x
tri-state buf(out, in, enable); // out = z when enable = 0
```

---

## Question 43: Write a Verilog task to add two vectors of N-bit width.

### 🔴 My Answer:
```verilog
task add_num (y);

y = a + b;
return y;

endtask
```

### 🟢 Correct Answer:

```verilog
module adder_task;
    parameter N = 8;
    reg [N-1:0] a, b, result;
    
    task add_vectors;
        input [N-1:0] operand1, operand2;
        output [N-1:0] sum;
        begin
            sum = operand1 + operand2;
        end
    endtask
    
    initial begin
        a = 8'h0F; b = 8'h10;
        add_vectors(a, b, result);
        $display("Sum = %h", result);
    end
endmodule
```

**Key Points:**
- Tasks don't return values (use `output` parameters)
- No `return` statement in Verilog tasks
- All variables must be declared with proper width

---

## Question 44: Differentiate between $time, $stime and $realtime.

### 🔴 My Answer:
$time: It shows the real time in which the tb is executed.
$stimer:
$realtime:

### 🟢 Correct Answer:

**System Time Functions:**

| Function | Return Type | Description |
|----------|-------------|-------------|
| **$time** | 64-bit integer | Current simulation time as integer |
| **$stime** | 32-bit integer | Current simulation time (lower 32 bits) |
| **$realtime** | Real number | Current simulation time as floating point |

**Usage Examples:**
```verilog
initial begin
    #10.5;
    $display("$time = %0t", $time);        // 105 (time units)
    $display("$stime = %0d", $stime);      // 105 
    $display("$realtime = %0g", $realtime); // 10.5
end
```

**Key Differences:**
- `$time`: Integer, good for most cases
- `$stime`: 32-bit version, legacy compatibility
- `$realtime`: Preserves fractional time units

---

## Question 45: Write code for a 4-bit shift register with SISO.

### 🔴 My Answer:
```verilog
module siso (clk, rst, sin, sout);

input clk, rst, sin;
output sout;

reg [3:0] shift_reg;

always@ (posedge clk or posedge rst) begin
if (rst) begin
shift_reg <= 4'b0000;
end else begin
shift_reg <= {shift_reg[2:0], sin};
end
end

assign sout = shift_reg[3];

endmodule
```

### 🟢 Correct Answer:

**Your code is mostly correct! Here's the cleaned version:**

```verilog
module siso_shift_register (
    input clk, rst, sin,
    output sout
);

reg [3:0] shift_reg;

always @(posedge clk or posedge rst) begin
    if (rst)
        shift_reg <= 4'b0000;
    else
        shift_reg <= {shift_reg[2:0], sin};
end

assign sout = shift_reg[3];

endmodule
```

**Operation:**
- **SISO:** Serial In, Serial Out
- Data shifts left each clock cycle
- Input enters at LSB, output from MSB
- Takes 4 clock cycles for data to appear at output

---

### 📝 **Legend:**
- 🔴 **My Answer** - Initial response  
- 🟢 **Correct Answer** - Accurate technical solution
- 🔷 **Key Points** - Important concepts to remember
