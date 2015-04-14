module registerFile32x32 (
	input clk, 
	input [4:0] regReadSel0, regReadSel1, regWriteSel,
	input writeEnable, // Write Enable
	input [31:0] writeData, 
	output [31:0] regReadData0, regReadData1
);
	wire regReadIndex, 
	// Register 0 always output 0
	register reg0(clk, 1'b0, writeEnable, writeData, readData);
	
	reg rst = 1'b1;

	genvar j;

		
	generate
		for (j = 0; j < 32; j++) begin: registerLoopj
			register (clk, rst, writeEnable, writeData, readData);
		end
	endgenerate



mux32_1 regRead0 (
	out,
	input [31:0] in,
	.sel(regReadSel0)
);

decoder5_32 (
	input [4:0] in,  
	output [31:0] out
);

endmodule