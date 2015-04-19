module registerFile32x32 (
	input clk, 
	input [4:0] regReadSel0, regReadSel1, regWriteSel,
	input writeEnable, // Write Enable
	input [31:0] writeData, 
	output [31:0] regReadData0, regReadData1
);
	wire regReadIndex;

	// The address to write
	wire [31:0] writeEnableDecoded;
	reg  [31:0] wrote;
	wire [31:0][31:0] stack;
	reg rst = 1'b0;

	// Step1: Decode the write address with writeEnable
	decoder5_32 writeDecode(regWriteSel, writeEnableDecoded);

	genvar i;
	generate
		for (i = 0; i < 32; i++) begin: wroteEnableLoop
			and wroteEnableAnd(wrote[i], writeEnable, writeEnableDecoded[i]);
		end
	endgenerate

	// Step2: form the stack with each row storing one word of 32 bit
	// Register 0 always output 0
	register reg0(clk, rst, wrote[0], 32'bx, stack[0]);
	
	genvar j;

	generate
		for (j = 1; j < 32; j++) begin: registerLoopj
			register regj (clk, ~rst, wrote[j], writeData, stack[j]);
		end
	endgenerate

	// Step3: using a mux to extrace a 32 bit word from the read address
	mux32by32_32 regMux0(regReadData0, stack, regReadSel0);
	mux32by32_32 regMux1(regReadData1, stack, regReadSel1);

endmodule