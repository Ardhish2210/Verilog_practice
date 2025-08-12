# 🔷 Verilog HDL & RTL Design Interview Questions (Continued)
---

## Question 6: What is the difference between $display, $monitor and $strobe? Which is best used inside clocked blocks and why?


### 🔴 My Answer:
$display: It is the statement which is only used to display the output of 1 test vector at a time ie In case of 4 test vectors we need to write the "$display" statement 4 times to display all the cases. </br> "$monitor": This statement is generally written before the test vectors are initialized and we need to right this statement only once in the whole testbench in order to display each and every test vectors written in the code.</br> "$strobe": I do not know about this statement. </br></br>
"$monitor" will be the best used inside the clocked block because it is easy to right the statement once then writing it after each and every time after assigning a test vector.

### 🟢 Correct Answer:
These are three different system tasks for displaying values during simulation, each with specific timing characteristics:

**$display:**
- Executes immediately when encountered in the code
- Prints values at the current simulation time
- Must be called explicitly each time you want output
- Can be used multiple times in the same time step

```verilog
always @(posedge clk) begin
    a <= b + 1;
    $display("Time %t: a = %d", $time, a); // Shows OLD value of 'a'
end
```

**$monitor:**
- Automatically executes whenever any of its arguments change
- Only one $monitor can be active at a time (subsequent calls override previous)
- Continuously monitors specified signals
- Executes at the end of current time step

```verilog
initial begin
    $monitor("Time %t: a = %d, b = %d", $time, a, b);
    // Will automatically print whenever a or b changes
end
```

**$strobe:**
- Executes at the END of the current simulation time step
- Shows final settled values after all non-blocking assignments complete
- Ideal for clocked logic verification
- Can be used multiple times in the same time step

```verilog
always @(posedge clk) begin
    a <= b + 1;
    $strobe("Time %t: a = %d", $time, a); // Shows NEW value of 'a'
end
```

**Best for clocked blocks:** **$strobe** is preferred because:
- It displays final values after all non-blocking assignments settle
- Avoids showing intermediate/old values
- Provides accurate representation of register states after clock edge
- Essential for debugging sequential logic

---

## Question 7: Design a 3-input majority gate in Verilog using only assign statements.

### 🔴 My Answer:
```verilog
module majority_gate (a, b, c, out);

input a, b, c;
output out;

assign out = (c & (a^b)) | (a&b);

endmodule
```

### 🟢 Correct Answer:
**Your answer is completely correct!** The expression `(c & (a^b)) | (a&b)` is a clever and valid implementation of a 3-input majority gate.

**Truth Table Verification:**
```
a | b | c | a^b | c&(a^b) | a&b | Final Output
--|---|---|-----|--------|-----|------------
0 | 0 | 0 |  0  |    0   |  0  |     0  ✓
0 | 0 | 1 |  0  |    0   |  0  |     0  ✓
0 | 1 | 0 |  1  |    0   |  0  |     0  ✓
0 | 1 | 1 |  1  |    1   |  0  |     1  ✓ (2 out of 3)
1 | 0 | 0 |  1  |    0   |  0  |     0  ✓
1 | 0 | 1 |  1  |    1   |  0  |     1  ✓ (2 out of 3)
1 | 1 | 0 |  0  |    0   |  1  |     1  ✓ (2 out of 3)
1 | 1 | 1 |  0  |    0   |  1  |     1  ✓ (3 out of 3)
```

**Logic explanation:**
- `(a&b)`: Covers cases where both a and b are 1
- `(c & (a^b))`: Covers cases where c=1 and exactly one of a or b is 1
- Together they cover all majority cases (≥2 inputs are 1)

**Alternative implementations:**
```verilog
// Method 1: Standard SOP form
assign out = (a & b) | (b & c) | (a & c);

// Method 2: Your creative solution
assign out = (c & (a^b)) | (a&b);

// Method 3: Alternative form
assign out = (a & b) | (c & (a | b));
```

Your solution demonstrates excellent logical thinking and understanding of Boolean algebra!

---

## Question 8: Write a Verilog code to detect a rising edge of a signal. How will you verify this in a testbench?


### 🔴 My Answer:
```verilog
module risingedgedetector (clk, d, rst, out);

reg q;
input clk;
input d;
input rst;
output reg out;

always @(posedge clk or posedge rst) begin
if (rst) begin
q <= 1'b0;
out <= 1'b0;
end else begin
out <= d & ~q;
q <= d;
end
end

endmodule
```

**TESTBENCH CODE:**
```verilog
`timescale 1ns/1ns
`include "risingedgedetector.v"

module risingedgedetector_tb;

reg clk, rst, d;
wire out;

risingedgedetector uut (clk, d, rst, out);

always #5 clk = ~clk;

initial begin
$dumpfile("risingedgedetector.vcd");
$dumpvars(0, risingedgedetector_tb);

clk = 0;
rst = 1;
d = 0;

$monitor ("Time: %0t || clk: %0d || rst: %0b || d: %0b || out: %0b", $time, clk, rst, d, out);

#8 rst = 0;
#3 d = 1;
#10 d = 0;
#10 d = 0;
#10 d = 1;

#10 $finish;

end
endmodule
```

### 🟢 Correct Answer:
The design is functionally correct! It implements a proper rising edge detector. Here's the analysis and an improved version:

**Design Analysis:**
```verilog
module rising_edge_detector (
    input clk,
    input rst,
    input signal,
    output reg edge_detected
);

reg signal_prev;

always @(posedge clk or posedge rst) begin
    if (rst) begin
        signal_prev <= 1'b0;
        edge_detected <= 1'b0;
    end else begin
        signal_prev <= signal;
        edge_detected <= signal & ~signal_prev; // Rising edge = current=1, previous=0
    end
end

endmodule
```

**Alternative Combinational Implementation:**
```verilog
module rising_edge_detector_comb (
    input clk,
    input rst,
    input signal
);

reg signal_prev;
wire edge_detected;

always @(posedge clk or posedge rst) begin
    if (rst)
        signal_prev <= 1'b0;
    else
        signal_prev <= signal;
end

assign edge_detected = signal & ~signal_prev;

endmodule
```

**Improved Testbench:**
```verilog
`timescale 1ns/1ps
module rising_edge_detector_tb;

reg clk, rst, signal;
wire edge_detected;

rising_edge_detector uut (
    .clk(clk),
    .rst(rst),
    .signal(signal),
    .edge_detected(edge_detected)
);

// Clock generation
always #5 clk = ~clk;

initial begin
    $dumpfile("rising_edge_detector.vcd");
    $dumpvars(0, rising_edge_detector_tb);
    
    // Initialize
    clk = 0;
    rst = 1;
    signal = 0;
    
    // Release reset
    #20 rst = 0;
    
    // Test cases
    #10 signal = 1;    // Rising edge - should detect
    #10 signal = 1;    // No edge
    #10 signal = 0;    // Falling edge - should not detect
    #10 signal = 1;    // Rising edge - should detect
    #5  signal = 0;    // Quick pulse
    #5  signal = 1;    // Another rising edge
    
    #20 $finish;
end

// Monitor with better formatting
always @(posedge clk) begin
    $strobe("Time: %0t | signal: %b | prev: %b | edge: %b", 
            $time, signal, uut.signal_prev, edge_detected);
end

endmodule
```

**Key improvements:**
- Added proper module ports in testbench instantiation
- Used $strobe for accurate clocked signal monitoring
- Better test sequence covering various edge scenarios
- Clear signal naming

---

## **Question 9: What is the default initial value of a register and wire in Verilog simulation?**

### 🔴 My Answer:
The default value of register in and wire in Verilog simulation is "x".

### 🟢 Correct Answer:
**Correct!** The default initial value for both `reg` and `wire` in Verilog simulation is `x` (unknown/uninitialized).

**Detailed explanation:**

**For `reg` variables:**
```verilog
reg [7:0] my_reg;        // Initial value: 8'bxxxxxxxx
reg single_bit;          // Initial value: 1'bx
reg [3:0] array [0:7];   // All elements: 4'bxxxx
```

**For `wire` nets:**
```verilog
wire [7:0] my_wire;      // Initial value: 8'bxxxxxxxx (if not driven)
wire single_wire;        // Initial value: 1'bx (if not driven)
```

**Important notes:**
- **Undriven wires:** Remain `x` until connected to a driver
- **Driven wires:** Take the value from their driver
- **Explicit initialization:** Can be overridden during declaration

```verilog
reg [7:0] initialized_reg = 8'h00;    // Initial value: 8'h00
wire [7:0] driven_wire = 8'hFF;       // Initial value: 8'hFF
```

**Synthesis vs Simulation:**
- **Simulation:** Starts with `x` values
- **Synthesis:** Physical hardware has random initial values (power-on state)
- **Reset logic:** Always include proper reset for predictable behavior

**Best practice:**
```verilog
always @(posedge clk or posedge rst) begin
    if (rst) begin
        my_reg <= 8'h00;  // Explicit reset value
    end else begin
        // Normal operation
    end
end
```

---

## **Question 10: How does Verilog handle race conditions?**
Describe a situation where two always blocks conflict.

### 🔴 My Answer:
The verilog outputs "x" whenever there is a race condition. The two always block conflict in the situation where JK flipflop (master slave flipflop) comes into picture.

### 🟢 Correct Answer:
Verilog handles race conditions through its event scheduling algorithm, but race conditions can still occur and cause unpredictable behavior. The simulator doesn't always output `x` - the result depends on the specific scenario.

**Race Condition Scenarios:**

**1. Multiple always blocks driving same variable:**
```verilog
reg shared_signal;

// RACE CONDITION - Two blocks driving same signal
always @(posedge clk) begin
    shared_signal = a;
end

always @(posedge clk) begin
    shared_signal = b;  // Conflict! Which assignment wins?
end
```

**Result:** Simulator-dependent - last assignment might win, or `x` might be assigned.

**2. Read-Write race in same time step:**
```verilog
reg data;

always @(posedge clk) begin
    data <= input_val;      // Non-blocking write
end

always @(posedge clk) begin
    output_val <= data;     // Reading data - old or new value?
end
```

**Result:** `output_val` might get old or new value of `data` depending on evaluation order.

**3. Mixed blocking/non-blocking assignments:**
```verilog
always @(posedge clk) begin
    a = b;          // Blocking assignment
    c <= a;         // Non-blocking - uses new or old value of a?
end
```

**4. Clock skew simulation:**
```verilog
always @(posedge clk1) begin
    data <= new_value;
end

always @(posedge clk2) begin  // clk2 might have slight delay
    output <= data;
end
```

**How Verilog handles races:**
- **Event scheduling:** Divides time into time slots with different regions (active, NBA, etc.)
- **Non-blocking assignments:** Scheduled for end of time step
- **Blocking assignments:** Execute immediately
- **Undefined order:** Multiple events at same time have undefined execution order

**Prevention strategies:**
```verilog
// 1. Use proper clocking methodology
always @(posedge clk) begin
    if (rst) begin
        data <= 0;
    end else begin
        data <= input_data;
    end
end

// 2. Use only one always block per signal
// 3. Follow blocking/non-blocking guidelines
// 4. Use synchronous design practices
```

**JK Flip-flop race condition example:**
```verilog
// Race condition in JK flip-flop implementation
always @(j or k or clk) begin
    if (clk) begin
        if (j && k)
            q = ~q;  // Toggle - creates race with q feeding back
        else if (j)
            q = 1;
        else if (k)
            q = 0;
    end
end
```

This creates a race because `q` changes, which triggers the sensitivity list again, potentially causing oscillation.

---

### 📝 **Legend:**
- 🔴 **My Answer** - Initial response
- 🟢 **Correct Answer** - Accurate technical solution
- 🔷 **Key Points** - Important concepts to remember
