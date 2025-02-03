# System Verilog
This repository contains notes related to SystemVerilog (SV) and the Universal Verification Methodology (UVM). Before delving into the semantics of SystemVerilog, basic examples are provided, such as a full adder for a combinational circuit and a simple counter for a sequential circuit, along with corresponding testbenches.

# 1. Example Codes
## Full Adder

```verilog
// 1-Bit Full Adder

// `define FA_METHOD1
// `define FA_METHOD2

`ifdef FA_METHOD1

// Method I
module fullAdder (
	input logic a, b, cIn,
	output logic sum, cOut
);
	logic wire1, wire2;
	assign wire1 = a ^ b;        // Bitwise XOR
	assign wire2 = wire1 & cIn;  // Bitwise AND
	wire wire3   = a & b;

	always_comb 
	begin
		cOut = wire2 | wire3;    // Bitwise OR
		sum  = wire1 ^ cIn;      
	end
endmodule

`endif

`ifdef FA_METHOD2

// Method II - Dataflow Model
module fullAdder (
	input logic a, b, cIn,
	output logic sum, cOut
);
	assign {cOut, sum} = a + b + cIn;
endmodule

`endif
```
