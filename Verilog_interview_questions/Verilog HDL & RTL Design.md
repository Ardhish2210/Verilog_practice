🔹 Verilog HDL \& RTL Design



##### ***21. What’s the difference between reg, wire, and logic in Verilog/SystemVerilog?***



MY ANSWER: Reg: we declare a variable as REG when we need to use it in procedural assignments such as "always block",

 		   Wire: we declare a variable as WIRE when we need to store any intermediate value in a circuit design.

                   Logic: It is a variable type which is used in SYSTEM VERILOG, it has the properties of both REG and WIRE, hence avoiding confusion and easy yo use as well.



**CORRECT ANSWER**: - reg: Used in Verilog when a signal is assigned inside a procedural block like always. Despite its name, it doesn’t represent a hardware register by default.

wire: Represents physical connections. It is used when a signal is driven by continuous assignments or connected to outputs of gates/modules.

logic: Introduced in SystemVerilog. It can replace both reg and wire and avoids confusion. It can be used in both procedural and continuous assignments.



#### ***22. Explain the use of case, casex, and casez.***



ANSWER: CASE: Used when we have different outputs in different conditions or cases, it handles only 0 and 1 value.

 		   CASEX: Used when we have different outputs in different conditions or cases, it is capable of handeling  0, 1 and X value.

 		   CASEZ: Used when we have different outputs in different conditions or cases, it is capable of handeling  0, 1, X and Z value.



**CORRECT ANSWER**: case: Standard case statement. Matches exact values (0 and 1 only). Does not ignore unknowns (X or Z).

casex: Treats both X and Z as don't-care conditions during matching. Can be risky for synthesis as it may produce unintended logic.

casez: Treats only Z as don't-care. Safer for synthesis and commonly used for matching with wildcards like addresses.



#### ***23. Write a Verilog module for an edge-triggered D flip-flop with synchronous reset.***



ANSWER: module (clk, rst, q, d);



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



**CORRECT ANSWER**:  module (clk, rst, q, d);



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





#### ***24. How do you model a finite state machine in Verilog?***



ANSWER :   module FSM\_module (clk, rst, in, out);



input clk, rst, in;

output reg out;



reg \[1:0] state, next\_state;

parameter S0 = 2'b00, S1 = 2'b01, S2 = 2'b10, S3 = 2'b11; 



always @(posedge clk or posedge rst) begin

&nbsp;   if(rst) begin

&nbsp;       state <= S0;

&nbsp;   end else begin 

&nbsp;       state <= next\_state;

&nbsp;   end

end



always @(\*) begin

&nbsp;   out = 1'b0;

&nbsp;   case (state)

&nbsp;   S0: begin

&nbsp;       next\_state = in ? S0:S1;

&nbsp;   end

&nbsp;   S1: begin

&nbsp;       next\_state = in ? S1:S2;

&nbsp;   end

&nbsp;   S2: begin

&nbsp;       next\_state = in ? S3:S1;

&nbsp;   end

&nbsp;   S3: begin

&nbsp;       next\_state = in ? S1:S0;

&nbsp;       out = 1'b1;

&nbsp;   end

&nbsp;   endcase

end

endmodule



CORRECT ANSWER: module FSM\_module (

&nbsp;   input clk,

&nbsp;   input rst,

&nbsp;   input in,

&nbsp;   output reg out

);



reg \[1:0] state, next\_state;

parameter S0 = 2'b00, S1 = 2'b01, S2 = 2'b10, S3 = 2'b11;



always @(posedge clk or posedge rst) begin

&nbsp;   if (rst)

&nbsp;       state <= S0;

&nbsp;   else

&nbsp;       state <= next\_state;

end



always @(\*) begin

&nbsp;   case (state)

&nbsp;       S0: next\_state = (in) ? S0 : S1;

&nbsp;       S1: next\_state = (in) ? S1 : S2;

&nbsp;       S2: next\_state = (in) ? S3 : S1;

&nbsp;       S3: next\_state = (in) ? S1 : S0;

&nbsp;       default: next\_state = S0;

&nbsp;   endcase

end



always @(\*) begin

&nbsp;   out = (state == S3) ? 1'b1 : 1'b0;

end



endmodule



#### ***25. What is a blocking vs non-blocking assignment with an example?***



ANSWER: Blocking assignment statement are the type of statments which are commonly used in normal combinational logic, 

NON-BLOCKING assignment statement are the statements which are used in ALWAYS @(POSEDGE CLK) block (sequential assignment).



example: A = B (blocking assignment), A <= B (non-blocking assignment) 



CORRECT ANSWER: Blocking assignment (=) executes statements in sequential order (one after the other). Commonly used in combinational logic.

Non-blocking assignment (<=) executes in parallel, all right-hand sides are evaluated first, then updated. Commonly used in sequential (clocked) logic.



// Blocking

always @(posedge clk) begin

&nbsp;   a = b;

&nbsp;   b = a;  // Incorrect behavior

end



// Non-blocking

always @(posedge clk) begin

&nbsp;   a <= b;

&nbsp;   b <= a;  // Correct behavior

end





#### ***26. What is the difference between simulation and synthesis?***



ANSWER: SIMULATION: It is basically the waveform output which we obtain after successfully running the Verilog code, SYNTHESIS: It is the process of making our Verilog design more efficient and maintaining a complete balance between Performance Power and Area.



&nbsp;CORRECT ANSWER: Simulation: Used to verify functionality of RTL design using testbenches. It checks logical correctness and timing at abstract level.

Synthesis: Converts RTL code into gate-level hardware. Focuses on optimizing for area, power, and timing. Only synthesis-friendly constructs are allowed.





#### ***27. What are X and Z values in simulation?***



ANSWER: X: If any of the variable is not pre-defined or having no initial value then we get "X" in the waveform,

Z: It is generally observed if there is a fault in design and u r not able to fetch the correct value.



CORREC T ANSWER: - X (Unknown): Indicates uninitialized signal or contention between multiple drivers. It can occur in simulation when multiple drivers assign conflicting values or due to uninitialized registers.

Z (High Impedance): Represents tri-stated outputs, e.g., in bidirectional buses. A Z means the signal is not driven by any source at that time.



#### ***28. Explain clock domain crossing (CDC) and how to handle it.***



ANSWER: Clock Domain Crossing (CDC): The condition in which the correct data which is given as an input is not received at the output due to the miss match in both the clocks is known as CDC, We can avoid CDC by using DOUBLE SYNCHRONIZERS so that the data can be received in a proper and correct manner. best example to avoid CDC is FIFO it uses double synchronizers in transferring the data.



CORRECT ANSWER: - \*\*Clock Domain Crossing (CDC)\*\*: Occurs when a signal transfers from one clock domain to another asynchronous domain. This can lead to \*\*metastability\*\*, where flip-flops output unstable or unpredictable values.



\*\*Common CDC Handling Techniques\*\*:

1\. \*\*Double Flop Synchronizer\*\*: For single-bit control signals.

2\. \*\*Handshake Protocols\*\*: For safe data transfer across domains.

3\. \*\*Asynchronous FIFOs\*\*: For burst or multi-bit data transfer with independent read/write clocks.



💡 Avoid glitches and metastability by never sampling asynchronous signals directly.





#### ***29. How do you ensure reusability and modularity in RTL code?***



CORRECT ANSWER:  To ensure reusability and modularity in RTL design:



Use parameterized modules: Allow configurable widths and behaviors using parameter.

Follow hierarchical design: Break large designs into smaller, well-defined submodules.

Maintain consistent coding style: Use meaningful names and indentation for readability.

Encapsulate functionality: Keep each module focused on a specific task.

Avoid hardcoded values: Use localparam or parameter instead of fixed constants.

Use interfaces (in SystemVerilog): To group related signals together and simplify port connections.

Create reusable testbenches and packages: Define common functions and macros in separate files.

Document the code: Add comments to describe module purpose, ports, and logic flow.



#### ***30. How do you write a testbench for a 4x1 multiplexer?***



CORRECT ANSWER: module mux4x1\_tb;



&nbsp; // Inputs

&nbsp; reg \[3:0] in;

&nbsp; reg \[1:0] sel;



&nbsp; // Output

&nbsp; wire out;



&nbsp; // Instantiate the DUT (Design Under Test)

&nbsp; mux4x1 DUT (

&nbsp;   .in(in),

&nbsp;   .sel(sel),

&nbsp;   .out(out)

&nbsp; );



&nbsp; initial begin

&nbsp;   // Test case 1

&nbsp;   in = 4'b1000; sel = 2'b11; #10;  // Expect out = 1

&nbsp;   in = 4'b0100; sel = 2'b10; #10;  // Expect out = 1

&nbsp;   in = 4'b0010; sel = 2'b01; #10;  // Expect out = 1

&nbsp;   in = 4'b0001; sel = 2'b00; #10;  // Expect out = 1

&nbsp;   in = 4'b1111; sel = 2'b10; #10;  // Expect out = 1

&nbsp;   in = 4'b0000; sel = 2'b01; #10;  // Expect out = 0



&nbsp;   $finish;

&nbsp; end



endmodule



