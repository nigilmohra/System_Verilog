// n-Bit Counter
module counter #(parameter BITSIZE = 8)
(
	input logic CLK, RST, increment,
	output logic [BITSIZE-1:0] countReg
);

always_ff @(posedge CLK) begin
	if(RST) countReg <= 0;
	else if (increment) countReg <= countReg + 1'b1;
end
endmodule

// TestBench
module counterTb;
	localparam BITSIZE = 8;
	logic CLK=0, RST, increment;
	logic [BITSIZE-1:0] countReg;

	counter #(.BITSIZE(BITSIZE)) dut(.*);

	localparam CLKPERIOD = 10;
	initial forever #(CLKPERIOD/2) CLK <= ~CLK;

	initial begin
		$dumpfile("dump.vcd");
		$dumpvars(0, dut);
		#(CLKPERIOD * 2)
		@(posedge CLK);
		#1 RST <= 1;
		repeat(2) @(posedge CLK);
		#1 increment <= 1;
		@(posedge CLK);
		#1 RST <= 0; increment <= 1;
		repeat(4) @(posedge CLK);
		#1 increment <= 0;
		repeat(4) @(posedge CLK);
		#1 RST <= 1;
      $finish(); // Simulation Ends
	end
endmodule