# 🔷 Verilog HDL & RTL Design

---

## **Question 21: What's the difference between reg, wire, and logic in Verilog/SystemVerilog?**

### 🔴 My Answer:
**Reg:** We declare a variable as REG when we need to use it in procedural assignments such as "always block"

**Wire:** We declare a variable as WIRE when we need to store any intermediate value in a circuit design.

**Logic:** It is a variable type which is used in SYSTEM VERILOG, it has the properties of both REG and WIRE, hence avoiding confusion and easy to use as well.

### 🟢 Correct Answer:
- **`reg`:** Used in Verilog when a signal is assigned inside a procedural block like always. Despite its name, it doesn't represent a hardware register by default.
- **`wire`:** Represents physical connections. It is used when a signal is driven by continuous assignments or connected to outputs of gates/modules.
- **`logic`:** Introduced in SystemVerilog. It can replace both reg and wire and avoids confusion. It can be used in both procedural and continuous assignments.

---

## **Question 22: Explain the use of case, casex, and casez.**

### 🔴 My Answer:
**CASE:** Used when we have different outputs in different conditions or cases, it handles only 0 and 1 value.

**CASEX:** Used when we have different outputs in different conditions or cases, it is capable of handling 0, 1 and X value.

**CASEZ:** Used when we have different outputs in different conditions or cases, it is capable of handling 0, 1, X and Z value.

### 🟢 Correct Answer:
- **`case`:** Standard case statement. Matches exact values (0 and 1 only). Does not ignore unknowns (X or Z).
- **`casex`:** Treats both X and Z as don't-care conditions during matching. Can be risky for synthesis as it may produce unintended logic.
- **`casez`:** Treats only Z as don't-care. Safer for synthesis and commonly used for matching with wildcards like addresses.

---

## **Question 23: Write a Verilog module for an edge-triggered D flip-flop with synchronous reset.**

### 🔴 My Answer:
```verilog
module (clk, rst, q, d);

    input clk, rst, d;
    output reg q;

    always @(posedge clk or posedge rst) begin
        if(rst) begin
            q <= 1'b0;
        end else begin
            q <= d;
        end
    end
endmodule.
```

### 🟢 Correct Answer:
```verilog
module (clk, rst, q, d);

    input clk, rst, d;
    output reg q;

    always @(posedge clk) begin
        if(rst) begin
            q <= 1'b0;
        end else begin
            q <= d;
        end
    end
endmodule.
```

---

## **Question 24: How do you model a finite state machine in Verilog?**

### 🔴 My Answer:
```verilog
module FSM_module (clk, rst, in, out);

input clk, rst, in;
output reg out;

reg [1:0] state, next_state;
parameter S0 = 2'b00, S1 = 2'b01, S2 = 2'b10, S3 = 2'b11; 

always @(posedge clk or posedge rst) begin
    if(rst) begin
        state <= S0;
    end else begin 
        state <= next_state;
    end
end

always @(*) begin
    out = 1'b0;
    case (state)
    S0: begin
        next_state = in ? S0:S1;
    end
    S1: begin
        next_state = in ? S1:S2;
    end
    S2: begin
        next_state = in ? S3:S1;
    end
    S3: begin
        next_state = in ? S1:S0;
        out = 1'b1;
    end
    endcase
end
endmodule
```

### 🟢 Correct Answer:
```verilog
module FSM_module (
    input clk,
    input rst,
    input in,
    output reg out
);

reg [1:0] state, next_state;
parameter S0 = 2'b00, S1 = 2'b01, S2 = 2'b10, S3 = 2'b11;

always @(posedge clk or posedge rst) begin
    if (rst)
        state <= S0;
    else
        state <= next_state;
end

always @(*) begin
    case (state)
        S0: next_state = (in) ? S0 : S1;
        S1: next_state = (in) ? S1 : S2;
        S2: next_state = (in) ? S3 : S1;
        S3: next_state = (in) ? S1 : S0;
        default: next_state = S0;
    endcase
end

always @(*) begin
    out = (state == S3) ? 1'b1 : 1'b0;
end

endmodule
```

---

## **Question 25: What is a blocking vs non-blocking assignment with an example?**

### 🔴 My Answer:
Blocking assignment statements are the type of statements which are commonly used in normal combinational logic.

NON-BLOCKING assignment statements are the statements which are used in ALWAYS @(POSEDGE CLK) block (sequential assignment).

**Example:** A = B (blocking assignment), A <= B (non-blocking assignment)

### 🟢 Correct Answer:
**Blocking assignment (=)** executes statements in sequential order (one after the other). Commonly used in combinational logic.

**Non-blocking assignment (<=)** executes in parallel, all right-hand sides are evaluated first, then updated. Commonly used in sequential (clocked) logic.

```verilog
// Blocking
always @(posedge clk) begin
    a = b;
    b = a;  // Incorrect behavior
end

// Non-blocking
always @(posedge clk) begin
    a <= b;
    b <= a;  // Correct behavior
end
```

---

## **Question 26: What is the difference between simulation and synthesis?**

### 🔴 My Answer:
**SIMULATION:** It is basically the waveform output which we obtain after successfully running the Verilog code.

**SYNTHESIS:** It is the process of making our Verilog design more efficient and maintaining a complete balance between Performance Power and Area.

### 🟢 Correct Answer:
**Simulation:** Used to verify functionality of RTL design using testbenches. It checks logical correctness and timing at abstract level.

**Synthesis:** Converts RTL code into gate-level hardware. Focuses on optimizing for area, power, and timing. Only synthesis-friendly constructs are allowed.

---

## **Question 27: What are X and Z values in simulation?**

### 🔴 My Answer:
**X:** If any of the variable is not pre-defined or having no initial value then we get "X" in the waveform.

**Z:** It is generally observed if there is a fault in design and you are not able to fetch the correct value.

### 🟢 Correct Answer:
- **X (Unknown):** Indicates uninitialized signal or contention between multiple drivers. It can occur in simulation when multiple drivers assign conflicting values or due to uninitialized registers.
- **Z (High Impedance):** Represents tri-stated outputs, e.g., in bidirectional buses. A Z means the signal is not driven by any source at that time.

---

## **Question 28: Explain clock domain crossing (CDC) and how to handle it.**

### 🔴 My Answer:
**Clock Domain Crossing (CDC):** The condition in which the correct data which is given as an input is not received at the output due to the mismatch in both the clocks is known as CDC. We can avoid CDC by using DOUBLE SYNCHRONIZERS so that the data can be received in a proper and correct manner. Best example to avoid CDC is FIFO it uses double synchronizers in transferring the data.

### 🟢 Correct Answer:
**Clock Domain Crossing (CDC):** Occurs when a signal transfers from one clock domain to another asynchronous domain. This can lead to **metastability**, where flip-flops output unstable or unpredictable values.

**Common CDC Handling Techniques:**
1. **Double Flop Synchronizer:** For single-bit control signals.
2. **Handshake Protocols:** For safe data transfer across domains.
3. **Asynchronous FIFOs:** For burst or multi-bit data transfer with independent read/write clocks.

> **Important:** Avoid glitches and metastability by never sampling asynchronous signals directly.

---

## **Question 29: How do you ensure reusability and modularity in RTL code?**

### 🟢 Correct Answer:
To ensure reusability and modularity in RTL design:

- **Use parameterized modules:** Allow configurable widths and behaviors using parameter.
- **Follow hierarchical design:** Break large designs into smaller, well-defined submodules.
- **Maintain consistent coding style:** Use meaningful names and indentation for readability.
- **Encapsulate functionality:** Keep each module focused on a specific task.
- **Avoid hardcoded values:** Use localparam or parameter instead of fixed constants.
- **Use interfaces (in SystemVerilog):** To group related signals together and simplify port connections.
- **Create reusable testbenches and packages:** Define common functions and macros in separate files.
- **Document the code:** Add comments to describe module purpose, ports, and logic flow.

---

## **Question 30: How do you write a testbench for a 4x1 multiplexer?**

### 🟢 Correct Answer:
```verilog
module mux4x1_tb;

  // Inputs
  reg [3:0] in;
  reg [1:0] sel;

  // Output
  wire out;

  // Instantiate the DUT (Design Under Test)
  mux4x1 DUT (
    .in(in),
    .sel(sel),
    .out(out)
  );

  initial begin
    // Test case 1
    in = 4'b1000; sel = 2'b11; #10;  // Expect out = 1
    in = 4'b0100; sel = 2'b10; #10;  // Expect out = 1
    in = 4'b0010; sel = 2'b01; #10;  // Expect out = 1
    in = 4'b0001; sel = 2'b00; #10;  // Expect out = 1
    in = 4'b1111; sel = 2'b10; #10;  // Expect out = 1
    in = 4'b0000; sel = 2'b01; #10;  // Expect out = 0

    $finish;
  end

endmodule
```

---

### 📝 **Legend:**
- 🔴 **My Answer** - Initial response
- 🟢 **Correct Answer** - Accurate technical solution
- 🔷 **Key Points** - Important concepts to remember
