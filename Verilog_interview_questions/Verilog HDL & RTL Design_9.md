# 🔷 Verilog HDL & RTL Design Interview Questions (36-40)
---

## Question 36: Explain metastability and how to solve it in Verilog.

### 🔴 My Answer:
METASTABILITY- The condition in which the data is not displayed at the output correctly at the desired clock cycle due to certain error.
Metastability is generally observed in ASYNCHRONOUS FIFO and thus to solve that issue we use 2 D-FF's for the data synchronizer so that the correct data is displayed.
In order to solve the issue in Verilog the one solution provided is that instead of one flip-flop we might use 2 flip-flop in series to obtain the correct output.

### 🟢 Correct Answer:

Metastability occurs when a flip-flop's input changes very close to the clock edge, causing the output to remain in an intermediate voltage level between logic 0 and 1 for an unpredictable amount of time.

**What Causes Metastability:**

**1. Clock Domain Crossing:**
```verilog
// PROBLEMATIC: Direct clock domain crossing
reg data_clk1, data_clk2;

always @(posedge clk1) begin
    data_clk1 <= async_input;
end

always @(posedge clk2) begin
    data_clk2 <= data_clk1;  // METASTABLE if clk1 and clk2 are asynchronous
end
```

**2. Asynchronous Input Sampling:**
```verilog
// PROBLEMATIC: Sampling asynchronous signal directly
always @(posedge clk) begin
    output_reg <= async_input;  // Can cause metastability
end
```

**Metastability Solutions:**

**1. Two-Stage Synchronizer (Most Common):**
```verilog
module synchronizer (
    input clk,
    input reset_n,
    input async_in,
    output sync_out
);

reg sync_reg1, sync_reg2;

always @(posedge clk or negedge reset_n) begin
    if (!reset_n) begin
        sync_reg1 <= 1'b0;
        sync_reg2 <= 1'b0;
    end else begin
        sync_reg1 <= async_in;      // First stage - may be metastable
        sync_reg2 <= sync_reg1;     // Second stage - resolves metastability
    end
end

assign sync_out = sync_reg2;

endmodule
```

**2. Multi-Stage Synchronizer for High-Speed Clocks:**
```verilog
module multi_stage_sync #(
    parameter STAGES = 3  // More stages for very high-speed clocks
) (
    input clk,
    input reset_n, 
    input async_in,
    output sync_out
);

reg [STAGES-1:0] sync_chain;

always @(posedge clk or negedge reset_n) begin
    if (!reset_n)
        sync_chain <= {STAGES{1'b0}};
    else
        sync_chain <= {sync_chain[STAGES-2:0], async_in};
end

assign sync_out = sync_chain[STAGES-1];

endmodule
```

**3. Handshake Protocol for Data:**
```verilog
module async_fifo_ctrl (
    // Write domain
    input wr_clk, wr_reset_n,
    input wr_en,
    output wr_full,
    
    // Read domain  
    input rd_clk, rd_reset_n,
    input rd_en,
    output rd_empty
);

// Gray code counters for clock domain crossing
reg [3:0] wr_ptr_gray, wr_ptr_gray_next;
reg [3:0] rd_ptr_gray, rd_ptr_gray_next;

// Synchronized gray pointers
reg [3:0] wr_ptr_gray_sync1, wr_ptr_gray_sync2;
reg [3:0] rd_ptr_gray_sync1, rd_ptr_gray_sync2;

// Write domain synchronizer
always @(posedge wr_clk or negedge wr_reset_n) begin
    if (!wr_reset_n) begin
        rd_ptr_gray_sync1 <= 4'b0;
        rd_ptr_gray_sync2 <= 4'b0;
    end else begin
        rd_ptr_gray_sync1 <= rd_ptr_gray;
        rd_ptr_gray_sync2 <= rd_ptr_gray_sync1;
    end
end

// Read domain synchronizer  
always @(posedge rd_clk or negedge rd_reset_n) begin
    if (!rd_reset_n) begin
        wr_ptr_gray_sync1 <= 4'b0;
        wr_ptr_gray_sync2 <= 4'b0;
    end else begin
        wr_ptr_gray_sync1 <= wr_ptr_gray;
        wr_ptr_gray_sync2 <= wr_ptr_gray_sync1;
    end
end

endmodule
```

**4. Reset Synchronizer:**
```verilog
module reset_synchronizer (
    input clk,
    input async_reset_n,
    output sync_reset_n
);

reg reset_sync1, reset_sync2;

// Asynchronous assert, synchronous deassert
always @(posedge clk or negedge async_reset_n) begin
    if (!async_reset_n) begin
        reset_sync1 <= 1'b0;
        reset_sync2 <= 1'b0;
    end else begin
        reset_sync1 <= 1'b1;
        reset_sync2 <= reset_sync1;
    end
end

assign sync_reset_n = reset_sync2;

endmodule
```

**Best Practices to Avoid Metastability:**

**1. Proper Timing Constraints:**
```verilog
// Set timing constraints for synchronizers
// set_max_delay -from [get_pins sync_reg1/Q] -to [get_pins sync_reg2/D] 5.0
```

**2. Use Dedicated Synchronizer Flip-Flops:**
```verilog
// Use flip-flops with good metastability characteristics
(* ASYNC_REG = "TRUE" *) reg sync_reg1;
(* ASYNC_REG = "TRUE" *) reg sync_reg2;
```

---

## Question 37: Write Verilog code for a one-pulse generator on rising edge.

### 🔴 My Answer:
```verilog
module one_pulse (clk, rst, signal_in, pulse_out);

  input clk;
  input rst;
  input signal_in;
  output reg pulse_out;
reg signal_prev;

always @(posedge clk or posedge rst) begin
if (rst) begin
signal_prev <= 0;
pulse_out <= 0;
end else begin
pulse_out <= signal_in & ~signal_prev;
signal_prev <= signal_in;
end
end

endmodule
```

### 🟢 Correct Answer:

A one-pulse generator creates a single clock-wide pulse when it detects a rising edge on the input signal.

**Basic One-Pulse Generator:**
```verilog
module one_pulse_generator (
    input clk,
    input reset_n,
    input signal_in,
    output pulse_out
);

reg signal_prev;

always @(posedge clk or negedge reset_n) begin
    if (!reset_n)
        signal_prev <= 1'b0;
    else
        signal_prev <= signal_in;
end

// Generate pulse on rising edge
assign pulse_out = signal_in & ~signal_prev;

endmodule
```

**Enhanced Version with Configurable Edge Detection:**
```verilog
module edge_pulse_generator #(
    parameter EDGE_TYPE = "RISING"  // "RISING", "FALLING", or "BOTH"
) (
    input clk,
    input reset_n,
    input signal_in,
    output reg pulse_out
);

reg signal_d1, signal_d2;

always @(posedge clk or negedge reset_n) begin
    if (!reset_n) begin
        signal_d1 <= 1'b0;
        signal_d2 <= 1'b0;
    end else begin
        signal_d1 <= signal_in;
        signal_d2 <= signal_d1;
    end
end

always @(*) begin
    case (EDGE_TYPE)
        "RISING":  pulse_out = signal_d1 & ~signal_d2;
        "FALLING": pulse_out = ~signal_d1 & signal_d2;
        "BOTH":    pulse_out = signal_d1 ^ signal_d2;
        default:   pulse_out = 1'b0;
    endcase
end

endmodule
```

**Multi-Clock Pulse Generator:**
```verilog
module multi_pulse_generator #(
    parameter PULSE_WIDTH = 3  // Pulse duration in clock cycles
) (
    input clk,
    input reset_n,
    input signal_in,
    output reg pulse_out
);

reg signal_prev;
reg [$clog2(PULSE_WIDTH+1)-1:0] counter;

always @(posedge clk or negedge reset_n) begin
    if (!reset_n) begin
        signal_prev <= 1'b0;
        counter <= 0;
        pulse_out <= 1'b0;
    end else begin
        signal_prev <= signal_in;
        
        if (signal_in & ~signal_prev) begin
            // Rising edge detected
            counter <= PULSE_WIDTH;
            pulse_out <= 1'b1;
        end else if (counter > 0) begin
            counter <= counter - 1;
            pulse_out <= 1'b1;
        end else begin
            pulse_out <= 1'b0;
        end
    end
end

endmodule
```

**Testbench for One-Pulse Generator:**
```verilog
module one_pulse_tb;

reg clk, reset_n, signal_in;
wire pulse_out;

one_pulse_generator dut (
    .clk(clk),
    .reset_n(reset_n),
    .signal_in(signal_in),
    .pulse_out(pulse_out)
);

// Clock generation
always #5 clk = ~clk;

initial begin
    $dumpfile("one_pulse.vcd");
    $dumpvars(0, one_pulse_tb);
    
    // Initialize
    clk = 0;
    reset_n = 0;
    signal_in = 0;
    
    // Reset sequence
    #20 reset_n = 1;
    
    // Test rising edges
    #30 signal_in = 1;
    #10 signal_in = 0;
    
    #20 signal_in = 1;
    #30 signal_in = 0;
    
    // Test multiple rising edges
    #10 signal_in = 1;
    #10 signal_in = 0;
    #10 signal_in = 1;
    #10 signal_in = 0;
    
    #50 $finish;
end

endmodule
```

---

## Question 38: How does synthesis interpret 'default' case in FSM design?

### 🔴 My Answer:
Default cases in FSM are used to avoid the formation of latches. For example there are 4 FSM states and then an input 5 is given in this case the DEAFULT statement will be executed, as far as the synthesis tool is concerned it will treat the default statement as decoder. By that way all the other possible FSM states will also be designated to the default statement output, eg: In case of 4 fsm states, we require 3bits. there will be a total of 8 cases, from which case 0 to 3 will have all the respective output which is assigned in the FSM logic, and the rest of the pins from 4 to 7 will have the pitput of DEFAULT to their respective output pin.

### 🟢 Correct Answer:

The `default` case in FSM design serves multiple critical purposes for synthesis tools and helps create robust, synthesizable finite state machines.

**How Synthesis Interprets Default:**

**1. Prevents Latch Inference:**
```verilog
// WITHOUT default - Creates latches!
always @(*) begin
    case (current_state)
        IDLE:    next_state = START;
        START:   next_state = PROCESS;
        PROCESS: next_state = DONE;
        // Missing: What if current_state = DONE?
        // Synthesis infers latch to hold previous value
    endcase
end

// WITH default - No latches
always @(*) begin
    case (current_state)
        IDLE:    next_state = START;
        START:   next_state = PROCESS; 
        PROCESS: next_state = DONE;
        default: next_state = IDLE;  // Explicit assignment
    endcase
end
```

**2. Handles Illegal States:**
```verilog
module fsm_with_recovery (
    input clk, reset_n,
    input start, done,
    output reg [2:0] state,
    output reg busy, error
);

localparam [2:0]
    IDLE    = 3'b000,
    START   = 3'b001, 
    PROCESS = 3'b010,
    WAIT    = 3'b011,
    DONE    = 3'b100;

always @(posedge clk or negedge reset_n) begin
    if (!reset_n)
        state <= IDLE;
    else begin
        case (state)
            IDLE:    if (start) state <= START;
            START:   state <= PROCESS;
            PROCESS: if (done) state <= WAIT;
                     else state <= PROCESS;
            WAIT:    state <= DONE;
            DONE:    state <= IDLE;
            
            // Handles illegal states (3'b101, 3'b110, 3'b111)
            default: begin
                state <= IDLE;  // Recovery to known state
            end
        endcase
    end
end

// Output logic with default
always @(*) begin
    busy = 1'b0;
    error = 1'b0;
    
    case (state)
        IDLE:    busy = 1'b0;
        START:   busy = 1'b1;
        PROCESS: busy = 1'b1;
        WAIT:    busy = 1'b1;
        DONE:    busy = 1'b0;
        default: begin
            busy = 1'b0;
            error = 1'b1;  // Signal illegal state
        end
    endcase
end

endmodule
```

**3. Synthesis Optimization Impact:**
```verilog
// Example: 4-state FSM using 3-bit encoding
module fsm_optimization (
    input clk, reset_n,
    input [1:0] cmd,
    output reg [2:0] current_state,
    output reg [3:0] control_signals
);

localparam [2:0]
    S0 = 3'b000,  // Used states: 000, 001, 010, 011
    S1 = 3'b001,  // Unused states: 100, 101, 110, 111
    S2 = 3'b010,
    S3 = 3'b011;

always @(posedge clk or negedge reset_n) begin
    if (!reset_n)
        current_state <= S0;
    else begin
        case (current_state)
            S0: case (cmd)
                2'b00: current_state <= S0;
                2'b01: current_state <= S1;
                2'b10: current_state <= S2;
                2'b11: current_state <= S3;
            endcase
            
            S1: current_state <= S0;
            S2: current_state <= S1;
            S3: current_state <= S2;
            
            // Without default: Synthesis may optimize away unused states
            // With default: Synthesis must handle all 8 possible combinations
            default: current_state <= S0;
        endcase
    end
end

endmodule
```

**4. Different Default Strategies:**

**Safe State Recovery:**
```verilog
always @(posedge clk or negedge reset_n) begin
    if (!reset_n)
        state <= RESET_STATE;
    else begin
        case (state)
            // ... normal states ...
            default: state <= RESET_STATE;  // Safe recovery
        endcase
    end
end
```

**Error State:**
```verilog
always @(posedge clk or negedge reset_n) begin
    if (!reset_n)
        state <= IDLE;
    else begin
        case (state)
            // ... normal states ...
            default: state <= ERROR_STATE;  // Dedicated error state
        endcase
    end
end
```

**Synthesis Directives:**
```verilog
// Synthesis directive to handle unused states
// synthesis translate_off
always @(posedge clk) begin
    case (state)
        // ... normal states ...
        default: begin
            $display("ERROR: Illegal state %b at time %t", state, $time);
            $stop;
        end
    endcase
end
// synthesis translate_on
```

**5. Full Safe FSM Template:**
```verilog
module safe_fsm #(
    parameter STATE_WIDTH = 3
) (
    input clk, reset_n,
    input start, stop,
    output reg active,
    output reg error
);

localparam [STATE_WIDTH-1:0]
    IDLE    = 3'b000,
    ACTIVE  = 3'b001,
    PAUSE   = 3'b010,
    STOP    = 3'b011;

reg [STATE_WIDTH-1:0] current_state, next_state;

// State register
always @(posedge clk or negedge reset_n) begin
    if (!reset_n)
        current_state <= IDLE;
    else
        current_state <= next_state;
end

// Next state logic  
always @(*) begin
    next_state = current_state;  // Default: stay in current state
    
    case (current_state)
        IDLE:   if (start) next_state = ACTIVE;
        ACTIVE: if (stop)  next_state = STOP;
                else       next_state = PAUSE;
        PAUSE:  next_state = ACTIVE;
        STOP:   next_state = IDLE;
        
        // Handle all unused state combinations
        default: next_state = IDLE;  // Safe recovery
    endcase
end

// Output logic
always @(*) begin
    // Default outputs
    active = 1'b0;
    error = 1'b0;
    
    case (current_state)
        IDLE:   active = 1'b0;
        ACTIVE: active = 1'b1;
        PAUSE:  active = 1'b1;
        STOP:   active = 1'b0;
        default: begin
            active = 1'b0;
            error = 1'b1;  // Flag illegal state
        end
    endcase
end

endmodule
```

**Impact on Hardware:**
- **Without default**: May create latches, unpredictable behavior
- **With default**: Ensures all states are handled, predictable synthesis
- **Area impact**: Default may slightly increase logic to handle unused states
- **Safety**: Provides graceful recovery from illegal states

---

## Question 39: Why is sensitivity list important in always blocks?

### 🔴 My Answer:
Sensitivity list plays a very crucial and the most important role in Verilog and any sequential/combinational circuit design as well. for eg:
CASE:01 always @(a or b or c) begin
assign y = (a & b & c & d);
end

CASE:02
always @(*) begin
assign y = (a & b & c & d);
end

The major difference between the above 2 cases is that in CASE-01 The output Y will change only when the value of "a" or "b" or "c" changes, it does not change when the value of "d" changes, and thus it will give the wrong output.
In CASE-02: The "*" denotes that whenever any of the input variable changes, the output will change and thus in this case the output will also change when "d" changes, and hence it will give the correct output. Similarly in case of SEQUENTIAL BLOCK as well sensitivity list play a important role....

### 🟢 Correct Answer:

The sensitivity list is crucial because it determines when an `always` block executes, directly affecting both simulation behavior and synthesis results.

**Types of Sensitivity Lists:**

**1. Combinational Logic - Complete Sensitivity:**
```verilog
// CORRECT: Complete sensitivity list
always @(a or b or c or d) begin
    y = a & b & c & d;  // Updates when any input changes
end

// BETTER: Use always @(*)
always @(*) begin
    y = a & b & c & d;  // Automatically includes all RHS signals
end

// PROBLEMATIC: Incomplete sensitivity list
always @(a or b) begin
    y = a & b & c & d;  // Won't update when c or d changes!
end
```

**2. Sequential Logic - Clock and Reset:**
```verilog
// Synchronous reset
always @(posedge clk) begin
    if (reset)
        q <= 1'b0;
    else
        q <= d;
end

// Asynchronous reset
always @(posedge clk or posedge reset) begin
    if (reset)
        q <= 1'b0;
    else  
        q <= d;
end
```

**Problems with Incorrect Sensitivity Lists:**

**1. Simulation vs Synthesis Mismatch:**
```verilog
// WRONG: Missing signals in sensitivity list
module mux_bad (
    input [1:0] sel,
    input [3:0] data_in,
    output reg data_out
);

// Only updates when sel[0] changes, not sel[1]!
always @(sel[0]) begin
    case (sel)
        2'b00: data_out = data_in[0];
        2'b01: data_out = data_in[1];
        2'b10: data_out = data_in[2];
        2'b11: data_out = data_in[3];
    endcase
end

endmodule

// CORRECT version
always @(*) begin  // or @(sel or data_in)
    case (sel)
        2'b00: data_out = data_in[0];
        2'b01: data_out = data_in[1];
        2'b10: data_out = data_in[2];
        2'b11: data_out = data_in[3];
    endcase
end
```

**2. Inferred Latches:**
```verilog
// CREATES LATCH: Incomplete conditions + wrong sensitivity
always @(enable) begin  // Missing data in sensitivity list
    if (enable)
        q = data;
    // No else clause - latch inferred!
end

// CORRECT: Complete sensitivity and logic
always @(*) begin
    if (enable)
        q = data;
    else
        q = 1'b0;  // Explicit else prevents latch
end
```

**3. Clock Domain Issues:**
```verilog
// WRONG: Multiple clock edges
always @(posedge clk1 or posedge clk2) begin
    // Synthesis error - can't have multiple clocks
    q <= d;
end

// CORRECT: Single clock domain
always @(posedge clk) begin
    q <= d;
end
```

**Best Practices:**

**1. Combinational Always Blocks:**
```verilog
// Method 1: Use @(*)
always @(*) begin
    // Combinational logic here
end

// Method 2: Explicit sensitivity (for complex cases)
always @(a or b or c or enable or select) begin
    // Combinational logic here  
end

// Method 3: SystemVerilog always_comb
always_comb begin
    // Automatically determines sensitivity
end
```

**2. Sequential Always Blocks:**
```verilog
// Standard flip-flop with async reset
always @(posedge clk or posedge reset) begin
    if (reset)
        // Reset logic
    else
        // Clock logic
end

// Synchronous reset only
always @(posedge clk) begin
    // Clock logic with sync reset
end
```

**3. Advanced Examples:**

**Priority Encoder with Complete Sensitivity:**
```verilog
module priority_encoder (
    input [7:0] data_in,
    output reg [2:0] encoded_out,
    output reg valid
);

always @(*) begin  // @(*) ensures all inputs are monitored
    encoded_out = 3'b000;
    valid = 1'b0;
    
    casez (data_in)
        8'b1???????: begin encoded_out = 3'd7; valid = 1'b1; end
        8'b01??????: begin encoded_out = 3'd6; valid = 1'b1; end
        8'b001?????: begin encoded_out = 3'd5; valid = 1'b1; end
        8'b0001????: begin encoded_out = 3'd4; valid = 1'b1; end
        8'b00001???: begin encoded_out = 3'd3; valid = 1'b1; end
        8'b000001??: begin encoded_out = 3'd2; valid = 1'b1; end
        8'b0000001?: begin encoded_out = 3'd1; valid = 1'b1; end
        8'b00000001: begin encoded_out = 3'd0; valid = 1'b1; end
        default:     begin encoded_out = 3'd0; valid = 1'b0; end
    endcase
end

endmodule
```

**State Machine with Proper Sensitivity:**
```verilog
module fsm_proper (
    input clk, reset_n,
    input start, stop,
    output reg active
);

reg [1:0] state, next_state;

// State register - only clock and reset
always @(posedge clk or negedge reset_n) begin
    if (!reset_n)
        state <= 2'b00;
    else
        state <= next_state;
end

// Next state logic - all control inputs
always @(*) begin  // Equivalent to @(state or start or stop)
    case (state)
        2'b00: next_state = start ? 2'b01 : 2'b00;
        2'b01: next_state = stop  ? 2'b00 : 2'b01;
        default: next_state = 2'b00;
    endcase
end

// Output logic - state dependent
always @(*) begin  // Equivalent to @(state)
    case (state)
        2'b00: active = 1'b0;
        2'b01: active = 1'b1;
        default: active = 1'b0;
    endcase
end

endmodule
```

**Common Mistakes and Solutions:**

```verilog
// MISTAKE 1: Missing clock in sensitivity list
always @(reset) begin  // WRONG!
    if (reset)
        q <= 1'b0;
    else
        q <= d;  // When does this execute?
end

// SOLUTION:
always @(posedge clk or posedge reset) begin
    if (reset)
        q <= 1'b0;
    else
        q <= d;
end

// MISTAKE 2: Incomplete combinational sensitivity
always @(sel) begin  // WRONG!
    case (sel)
        2'b00: out = in0;  // Doesn't update when in0-in3 change
        2'b01: out = in1;
        2'b10: out = in2;
        2'b11: out = in3;
    endcase
end

// SOLUTION:
always @(sel or in0 or in1 or in2 or in3) begin  // or @(*)
    case (sel)
        2'b00: out = in0;
        2'b01: out = in1;
        2'b10: out = in2;
        2'b11: out = in3;
    endcase
end
```

---

## Question 40: Create a pulse stretcher module using Verilog.

### 🔴 My Answer:
```verilog
module pulse (clk, rst, in_pulse, out_pulse);

parameter stretch_length = 8;
input clk, rst, in_pulse;
output reg out_pulse;
reg [3:0] counter;

always @(posedge clk or posedge rst) begin
if (rst) begin
out_pulse <= 1'b0;
counter <= 0;
end else begin
if (in_pulse) begin
out_pulse <= 1'b1;
counter <= stretch_length;
end else if (counter != 0) begin
out_pulse <= 1'b1;
counter <= counter - 1;
end else begin
out_pulse <= 1'b0;
end
end
end

endmodule
```

### 🟢 Correct Answer:

A pulse stretcher extends the duration of short input pulses to ensure they're detectable by slower systems or to meet minimum pulse width requirements.

**Basic Pulse Stretcher:**
```verilog
module pulse_stretcher #(
    parameter STRETCH_CYCLES = 8,
    parameter COUNTER_WIDTH = $clog2(STRETCH_CYCLES + 1)
) (
    input clk,
    input reset_n,
    input pulse_in,
    output reg pulse_out
);

reg [COUNTER_WIDTH-1:0] counter;

always @(posedge clk or negedge reset_n) begin
    if (!reset_n) begin
        counter <= 0;
        pulse_out <= 1'b0;
    end else begin
        if (pulse_in) begin
            // New pulse detected - restart stretching
            counter <= STRETCH_CYCLES;
            pulse_out <= 1'b1;
        end else if (counter > 0) begin
            // Continue stretching
            counter <= counter - 1;
            pulse_out <= 1'b1;
        end else begin
            // Stretch period completed
            pulse_out <= 1'b0;
        end
    end
end

endmodule
```

**Advanced Pulse Stretcher with Edge Detection:**
```verilog
module advanced_pulse_stretcher #(
    parameter STRETCH_CYCLES = 16,
    parameter COUNTER_WIDTH = $clog2(STRETCH_CYCLES + 1),
    parameter EDGE_TYPE = "RISING"  // "RISING", "FALLING", "BOTH"
) (
    input clk,
    input reset_n,
    input signal_in,
    output reg pulse_out,
    output reg busy  // Indicates stretching in progress
);

reg signal_d1, signal_d2;
reg [COUNTER_WIDTH-1:0] counter;
wire edge_detected;

// Edge detection
always @(posedge clk or negedge reset_n) begin
    if (!reset_n) begin
        signal_d1 <= 1'b0;
        signal_d2 <= 1'b0;
    end else begin
        signal_d1 <= signal_in;
        signal_d2 <= signal_d1;
    end
end

// Generate edge detection signal based on parameter
generate
    if (EDGE_TYPE == "RISING") begin
        assign edge_detected = signal_d1 & ~signal_d2;
    end else if (EDGE_TYPE == "FALLING") begin
        assign edge_detected = ~signal_d1 & signal_d2;
    end else if (EDGE_TYPE == "BOTH") begin
        assign edge_detected = signal_d1 ^ signal_d2;
    end else begin
        assign edge_detected = 1'b0;
    end
endgenerate

// Pulse stretching logic
always @(posedge clk or negedge reset_n) begin
    if (!reset_n) begin
        counter <= 0;
        pulse_out <= 1'b0;
        busy <= 1'b0;
    end else begin
        if (edge_detected && !busy) begin
            // New edge detected and not currently busy
            counter <= STRETCH_CYCLES;
            pulse_out <= 1'b1;
            busy <= 1'b1;
        end else if (counter > 0) begin
            // Continue stretching
            counter <= counter - 1;
            pulse_out <= 1'b1;
            busy <= 1'b1;
        end else begin
            // Stretch period completed
            pulse_out <= 1'b0;
            busy <= 1'b0;
        end
    end
end

endmodule
```

**Retriggerable Pulse Stretcher:**
```verilog
module retriggerable_pulse_stretcher #(
    parameter STRETCH_CYCLES = 10,
    parameter COUNTER_WIDTH = $clog2(STRETCH_CYCLES + 1)
) (
    input clk,
    input reset_n,
    input pulse_in,
    output reg pulse_out,
    output reg [COUNTER_WIDTH-1:0] time_remaining
);

reg [COUNTER_WIDTH-1:0] counter;
reg pulse_d1;

// Edge detection for input pulse
always @(posedge clk or negedge reset_n) begin
    if (!reset_n)
        pulse_d1 <= 1'b0;
    else
        pulse_d1 <= pulse_in;
end

wire pulse_edge = pulse_in & ~pulse_d1;

always @(posedge clk or negedge reset_n) begin
    if (!reset_n) begin
        counter <= 0;
        pulse_out <= 1'b0;
    end else begin
        if (pulse_edge) begin
            // Retrigger: restart counter even if already running
            counter <= STRETCH_CYCLES;
            pulse_out <= 1'b1;
        end else if (counter > 0) begin
            counter <= counter - 1;
            pulse_out <= 1'b1;
        end else begin
            pulse_out <= 1'b0;
        end
    end
end

assign time_remaining = counter;

endmodule
```

**Programmable Pulse Stretcher:**
```verilog
module programmable_pulse_stretcher #(
    parameter MAX_STRETCH = 255,
    parameter COUNTER_WIDTH = $clog2(MAX_STRETCH + 1)
) (
    input clk,
    input reset_n,
    input pulse_in,
    input [COUNTER_WIDTH-1:0] stretch_value,
    input enable,
    output reg pulse_out,
    output reg active
);

reg [COUNTER_WIDTH-1:0] counter;
reg pulse_d1;

// Edge detection
always @(posedge clk or negedge reset_n) begin
    if (!reset_n)
        pulse_d1 <= 1'b0;
    else
        pulse_d1 <= pulse_in;
end

wire pulse_edge = pulse_in & ~pulse_d1;

always @(posedge clk or negedge reset_n) begin
    if (!reset_n) begin
        counter <= 0;
        pulse_out <= 1'b0;
        active <= 1'b0;
    end else if (!enable) begin
        // Pass through when disabled
        pulse_out <= pulse_in;
        counter <= 0;
        active <= 1'b0;
    end else begin
        if (pulse_edge) begin
            if (stretch_value == 0) begin
                // No stretching, pass through
                pulse_out <= 1'b1;
                counter <= 0;
                active <= 1'b0;
            end else begin
                // Start stretching
                counter <= stretch_value;
                pulse_out <= 1'b1;
                active <= 1'b1;
            end
        end else if (counter > 0) begin
            counter <= counter - 1;
            pulse_out <= 1'b1;
            active <= 1'b1;
        end else begin
            pulse_out <= 1'b0;
            active <= 1'b0;
        end
    end
end

endmodule
```

**Pulse Stretcher with Minimum Width Guarantee:**
```verilog
module min_width_pulse_stretcher #(
    parameter MIN_WIDTH_CYCLES = 5,
    parameter COUNTER_WIDTH = $clog2(MIN_WIDTH_CYCLES + 1)
) (
    input clk,
    input reset_n,
    input pulse_in,
    output reg pulse_out
);

reg [COUNTER_WIDTH-1:0] counter;
reg input_active;

always @(posedge clk or negedge reset_n) begin
    if (!reset_n) begin
        counter <= 0;
        pulse_out <= 1'b0;
        input_active <= 1'b0;
    end else begin
        input_active <= pulse_in;
        
        if (pulse_in && !input_active) begin
            // Rising edge of input pulse
            counter <= MIN_WIDTH_CYCLES;
            pulse_out <= 1'b1;
        end else if (pulse_in && counter > 0) begin
            // Input still high, continue counting down
            counter <= counter - 1;
            pulse_out <= 1'b1;
        end else if (!pulse_in && counter > 0) begin
            // Input went low but minimum width not met
            counter <= counter - 1;
            pulse_out <= 1'b1;
        end else if (!pulse_in && counter == 0) begin
            // Input low and minimum width satisfied
            pulse_out <= 1'b0;
        end else if (pulse_in && counter == 0) begin
            // Input high and minimum width satisfied
            pulse_out <= 1'b1;
        end
    end
end

endmodule
```

**Comprehensive Testbench:**
```verilog
module pulse_stretcher_tb;

reg clk, reset_n, pulse_in;
wire pulse_out, busy;

// Instantiate DUT
advanced_pulse_stretcher #(
    .STRETCH_CYCLES(5),
    .EDGE_TYPE("RISING")
) dut (
    .clk(clk),
    .reset_n(reset_n),
    .signal_in(pulse_in),
    .pulse_out(pulse_out),
    .busy(busy)
);

// Clock generation
always #5 clk = ~clk;

initial begin
    $dumpfile("pulse_stretcher.vcd");
    $dumpvars(0, pulse_stretcher_tb);
    
    // Initialize
    clk = 0;
    reset_n = 0;
    pulse_in = 0;
    
    // Reset sequence
    #20 reset_n = 1;
    
    // Test 1: Single short pulse
    #30 pulse_in = 1;
    #10 pulse_in = 0;
    
    // Wait for stretch to complete
    #100;
    
    // Test 2: Multiple pulses during stretch
    pulse_in = 1;
    #10 pulse_in = 0;
    #20 pulse_in = 1;  // During stretch period
    #10 pulse_in = 0;
    
    #100;
    
    // Test 3: Long pulse
    pulse_in = 1;
    #80 pulse_in = 0;
    
    #100 $finish;
end

// Monitor
initial begin
    $monitor("Time=%0t | pulse_in=%b | pulse_out=%b | busy=%b", 
             $time, pulse_in, pulse_out, busy);
end

endmodule
```

**Applications:**
- **Debouncing**: Stretch button presses to eliminate bounce
- **Interface synchronization**: Ensure minimum pulse width for slow devices  
- **Signal conditioning**: Convert narrow glitches to detectable pulses
- **Handshake protocols**: Guarantee minimum acknowledge pulse width

---

### 📝 **Legend:**
- 🔴 **My Answer** - Initial response  
- 🟢 **Correct Answer** - Accurate technical solution
- 🔷 **Key Points** - Important concepts to remember
