# 🔷 Verilog HDL & RTL Design Interview Questions
---

## **Question 1: What is the difference between a blocking and non-blocking assignment in Verilog?**
Give one real-time example where this difference can break your design.

### 🔴 My Answer:
Blocking assignment statements assign the value in SEQUENTIAL manner, whereas the NON-BLOCKING statement assign the value PARALLEL manner, Non- blocking assignment statements are commonly used in "sequential logic circuits" (always @(posedge clk) block). Real time example:

```

---

## **Question 4: What will be the output of this code?**
```verilog
reg [3:0] a = 4'b0011;
reg [3:0] b = 4'b0101;
initial begin
a = b & a;
$display("%b", a);
end
```
Is it synthesizable?

### 🔴 My Answer:
The above code will run perfectly and hence it will give display "0001" as output, but as far as the synthesis is concerned it will not synthesis as "initial block" and "$display" statements are ignored by the synthesis tool.

### 🟢 Correct Answer:
The output will be `0001`.

**Step-by-step execution:**
```verilog
a = 4'b0011 (initial value)
b = 4'b0101 (initial value)
a = b & a = 4'b0101 & 4'b0011 = 4'b0001
$display("%b", a) outputs: 0001
```

**Synthesizability:** This code is **NOT synthesizable** for several reasons:

1. **`initial` blocks**: Generally not synthesizable (except for specific initialization cases in some tools)
2. **`$display` statements**: System tasks are simulation-only, ignored by synthesis
3. **Initialization values**: The `= 4'b0011` initialization may or may not be synthesizable depending on the target technology and synthesis tool

**To make it synthesizable (if needed):**
```verilog
reg [3:0] a, b;
wire [3:0] result;

assign result = b & a;  // Combinational logic

// Or in a clocked process:
always @(posedge clk) begin
    if (reset) begin
        a <= 4'b0011;
        b <= 4'b0101;
    end else begin
        a <= b & a;
    end
end
```

---

## **Question 5: Why always @(*) is preferred over always @ (a or b or c)?** 
Explain the design advantage and simulator behavior.

### 🔴 My Answer:
always @(*) block signifies that whenever any of the inputs change the content of the always @(*) block is executed, but in case of "always @(a or b or c)" it might be possible that we must forget to add variable which is declared as an input but not mentioned in the "always @(a or b or c)" block, and hence the code will not give the desired output.

### 🟢 Correct Answer:
`always @(*)` is preferred over explicit sensitivity lists for combinational logic due to several important advantages:

**1. Automatic sensitivity list generation:**
```verilog
// Manual sensitivity list - ERROR PRONE
always @(a or b or c) begin
    out1 = a & b;
    out2 = c | d;  // 'd' missing from sensitivity list!
end

// Automatic sensitivity list - SAFE
always @(*) begin
    out1 = a & b;
    out2 = c | d;  // All inputs automatically included
end
```

**2. Design advantages:**
- **Maintainability**: Automatically updates when code changes
- **Error prevention**: Eliminates incomplete sensitivity list bugs
- **Code clarity**: Intent is clearer (combinational logic)
- **Reduced debugging**: No simulation/synthesis mismatches due to missing signals

**3. Simulator behavior differences:**

**Incomplete sensitivity list:**
```verilog
always @(a or b) begin  // 'c' missing
    out = a & b & c;
end
// Simulation: out only updates when a or b change, not when c changes
// Synthesis: Creates combinational logic sensitive to a, b, AND c
// Result: Simulation/synthesis mismatch!
```

**Complete automatic sensitivity:**
```verilog
always @(*) begin
    out = a & b & c;
end
// Simulation: out updates when any input (a, b, or c) changes
// Synthesis: Creates combinational logic sensitive to a, b, and c
// Result: Simulation matches synthesis perfectly
```

**4. Synthesis tool behavior:**
- Both approaches synthesize to the same hardware
- `always @(*)` prevents simulation/synthesis mismatches
- Synthesis tools analyze the actual logic, not the sensitivity list

**Best practices:**
- Use `always @(*)` for all combinational logic
- Use explicit sensitivity lists only for specific sequential logic (e.g., `always @(posedge clk)`)
- Never mix `always @(*)` with clocked logic

---

### 📝 **Legend:**
- 🔴 **My Answer** - Initial response
- 🟢 **Correct Answer** - Accurate technical solution
- 🔷 **Key Points** - Important concepts to rememberverilog
// Case-01
always @(posedge clk) begin
 	a <= b;
 	b <= c;
 	c <= d;
 	d <= e;
end

// Case-02
always @(posedge clk) begin
	a = b;
	b = c;
	c = d;
	d = e;
end
```

Now, in case 1: All the variables present in LHS will be computed first and then at the posedge clk will be simultaneouslt assigned to a, b, c and d;
and in case 2: after all the iteration the final conclusion will be a = e; and hence the output in both the cases are different
this could cause logical errors and hence the design will not be correct.

### 🟢 Correct Answer:
Blocking assignments (`=`) execute sequentially within a simulation time step, while non-blocking assignments (`<=`) schedule updates to occur at the end of the current simulation time step, allowing parallel execution.

**Key differences:**
- **Blocking (`=`)**: Executes immediately, blocks subsequent statements until complete
- **Non-blocking (`<=`)**: Schedules assignment for end of time step, allows parallel evaluation

**Design-breaking example:**
```verilog
// Intended: Simple shift register
// Case 1: Non-blocking (CORRECT)
always @(posedge clk) begin
    a <= b;
    b <= c;
    c <= d;
end
// Result: a gets old_b, b gets old_c, c gets old_d (proper shift)

// Case 2: Blocking (INCORRECT for sequential logic)
always @(posedge clk) begin
    a = b;
    b = c;
    c = d;
end
// Result: All variables get the value of d (chain reaction)
```

**Guidelines:**
- Use non-blocking (`<=`) for sequential logic (clocked always blocks)
- Use blocking (`=`) for combinational logic (always @(*) blocks)

---

## **Question 2: How can you infer a latch unintentionally in Verilog?**
Give code snippet that creates a latch and how to correct it.

### 🔴 My Answer:
If we do not write the "default" statement while writing the case statements then we can unintentionally infer a latch in our design. secondly we can also get a latch when the "If-else" statement is written without an else condition, Latches are formed when the output variable retains its value

```verilog
input a;
output out;
always @(*) begin
 		if(enable) out = a;
 	end
```

In-order to correct the code and remove the latch we must:

```verilog
input a;
output out;
always @(*) begin
 		if(enable) out = a;
 		else out = 1'b0;
end
```
The above code will remove the latch.

### 🟢 Correct Answer:
Latches are inferred when synthesis tools detect that a signal may not be assigned a value under all possible input conditions in combinational logic. This creates memory behavior (latch) to hold the previous value.

**Common scenarios causing latches:**

**1. Incomplete if-else statements:**
```verilog
// LATCH INFERRED - Missing else
always @(*) begin
    if (enable)
        out = a;
    // Missing else - out retains previous value when enable=0
end

// CORRECTED
always @(*) begin
    if (enable)
        out = a;
    else
        out = 1'b0; // or some default value
end
```

**2. Incomplete case statements:**
```verilog
// LATCH INFERRED - Missing default
always @(*) begin
    case (sel)
        2'b00: out = a;
        2'b01: out = b;
        // Missing cases for 2'b10 and 2'b11
    endcase
end

// CORRECTED
always @(*) begin
    case (sel)
        2'b00: out = a;
        2'b01: out = b;
        default: out = 1'b0;
    endcase
end
```

**3. Variables not assigned in all paths:**
```verilog
// LATCH INFERRED
always @(*) begin
    if (condition1)
        out1 = a;
    if (condition2)
        out1 = b;
    // out1 not assigned when both conditions are false
end
```

---

## **Question 3: Can you assign a reg to a wire?**
Explain with an example and explain synthesis behavior.

### 🔴 My Answer:
Yes, we can assign reg to a wire but in a certain condition 

```verilog
reg a;
wire b;
assign b = a;  // This is valid
```

but:  

```verilog
reg a;
wire b;
always @(posedge clk) begin
	b = a; 	// This is wrong and not synthesizable as well
end
```

In terms of synthesis behaviour it just means that we are connecting a reg output to a wire.

### 🟢 Correct Answer:
Yes, you can assign a `reg` to a `wire`, but only through continuous assignment using the `assign` statement, not within procedural blocks.

**Valid assignment:**
```verilog
reg a;
wire b;
assign b = a;  // VALID: Continuous assignment
```

**Invalid assignments:**
```verilog
reg a;
wire b;

// INVALID: Cannot drive wire from procedural block
always @(posedge clk) begin
    b = a;  // Compilation error
end

// INVALID: Cannot assign to wire in procedural block
always @(*) begin
    b = a;  // Compilation error
end
