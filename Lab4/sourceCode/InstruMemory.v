// Instruction Memory 128 * 32 SRAM
// EE 471 Lab 4, Beck Pang, Spring 2015
module InstruMemory (clk, adx, WrEn, data);
	parameter DATA_WIDTH = 32;
	parameter DATA_LENGTH= 128;
	parameter ADX_LENGTH = 7;

	input clk, WrEn;
	input [ADX_LENGTH - 1:0] adx;
	inout [DATA_WIDTH - 1:0] data;

	reg [DATA_WIDTH - 1:0]SRAM[DATA_LENGTH - 1:0]; // memory regs
	
	assign data = (WrEn) ? SRAM[adx] : 32'bZ; // control the tri-state 
	
	always @(posedge clk) begin
		if(~WrEn) 
				SRAM[adx] = data; // assign the SRAM index to data
	end

endmodule