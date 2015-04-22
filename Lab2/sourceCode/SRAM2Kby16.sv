// AJ, Beck, and Ray
// SRAM module and testbench

module SRAM2Kby16(clk, adx, chpSel, OutEn, WrEn, data);
	input clk, chpSel, OutEn, WrEn;
	input [11:0] adx;
	inout [15:0] data;

	reg [2047:0][15:0] SRAM; // memory regs
	
	assign data = (OutEn) ? 16'bZ : SRAM[adx]; // control the tri-state
	
	always @(posedge clk) begin
		if(~(chpSel | WrEn)) // chip selected
				SRAM[adx] = data; // assign the SRAM index to data
	end
endmodule 