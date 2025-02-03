# System Verilog
This repository contains notes related to SystemVerilog (SV) and the Universal Verification Methodology (UVM). Before delving into the semantics of SystemVerilog, basic examples are provided, such as a full adder for a combinational circuit and a simple counter for a sequential circuit, along with corresponding testbenches.

# 1. Example Codes
## 1.1. Full Adder (Combinational Circuit Example)
```systemverilog
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
// Method II 
module fullAdder (
	input logic a, b, cIn,
	output logic sum, cOut
);
	assign {cOut, sum} = a + b + cIn;
endmodule
`endif

// TestBench
module fullAdderTb;
	logic a = 0, cIn = 0, b, sum, cOut; // b != 0
	fullAdder dut(.*);
	initial begin // Simulation Begins
	$dumpfile("dump.vcd"); 
	$dumpvars(1);
	#30 a <= 0; b <= 0; cIn <= 0;
	#10 a <= 0; b <= 0; cIn <= 1;
	#20 a <= 1; b <= 0; cIn <= 1;
      #1 assert ({cOut, sum} == a + b + cIn)
		$display("Pass");
		else $error("Fail");
	#10 a <= 1; b <= 1; cIn <= 1;
	#1 assert(dut.wire1 == 0)
		else $error("False.wire1:%d", dut.wire1);
	$finish(); // Simulation Ends
	end
endmodule
```
