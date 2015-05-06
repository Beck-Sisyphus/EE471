// AJ, Beck, and Ray
// small SRAM module storing instruction set
// 5/5/15

module SRAM128by16(clk, adx, WrEn, data);
	parameter ADDRESS_LENGTH = 7;
	parameter DATA_WIDTH = 16;
	parameter DATA_LENGTH= 128;

	input clk, WrEn;
	input [(ADDRESS_LENGTH - 1):0] adx;
	inout [(DATA_WIDTH - 1):0] data;

	reg [(DATA_WIDTH - 1):0]SRAM[(DATA_LENGTH - 1):0]; // memory regs
	
	assign data = (WrEn) ? SRAM[adx] : (DATA_WIDTH)'bZ; // control the tri-state 
	
	always @(posedge clk) begin
		if(~WrEn) 
				SRAM[adx] = data; // assign the SRAM index to data
	end
endmodule  