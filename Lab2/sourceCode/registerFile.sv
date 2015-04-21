// UWEE, Beck Pang, Raymond Mui, Andrew J. Townsend
// EE 471 Lab 2, Apr.20, 2015
// This module is a piece of a synchronous memory system that store the most accessed data
// called register file, with 32 registers of 32 bit wide.
// The first register is set as ground reference and always output
// It takes clock, address and signals from the system bus, 
// have both read or write function, read data from or write data to registers.
// Read Operation:
//	@requires:  a clock signal, a low signal for write enable,
// 			two read address width of 5 bits;
//	@returns:	a data of 32 bits specified by the address;
// Write Operation:
//  @requires:	a clock signal, a high signal for write enable,
// 			a write address with width of 5 bits, and an data with width of 32 bits;
// 	@modifies:	the data of the address passed in

// `include "decoder5_32.sv"
// `include "register.sv"
// `include "mux32by32_32.sv"
module registerFile (
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
	reg [31:0] RF [31:0];
	reg rst = 1'b0;

	// Step1: Decode the write address with writeEnable
	decoder5_32 writeDecode(regWriteSel, writeEnableDecoded);

	genvar i;
	generate
		for (i = 0; i < 32; i = i + 1) begin: wroteEnableLoop
			and wroteEnableAnd(wrote[i], writeEnable, writeEnableDecoded[i]);
		end
	endgenerate

	// Step2: form the RF with each row storing one word of 32 bit
	// Register 0 always output 0
	register reg0(clk, rst, wrote[0], 32'bx, RF[0]);
	
	genvar j;

	generate
		for (j = 1; j < 32; j = j + 1) begin: registerLoopj
			register regj (clk, ~rst, wrote[j], writeData, RF[j]);
		end
	endgenerate

	// Step3: using a mux to extrace a 32 bit word from the read address
	mux32by32_32 regMux0(regReadData0, RF, regReadSel0);
	mux32by32_32 regMux1(regReadData1, RF, regReadSel1);

endmodule