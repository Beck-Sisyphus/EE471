// AJ, Beck, and Ray
// SRAM module
// 4/21/15

module SRAM2Kby16(clk, adx, WrEn, data);
	input clk, WrEn;
	input [10:0] adx;
	inout [15:0] data;

	reg [15:0]SRAM[2047:0]; // memory regs
	
	assign data = (WrEn) ? SRAM[adx] : 16'bZ; // control the tri-state 
	
	always @(posedge clk) begin
		if(~WrEn) 
				SRAM[adx] = data; // assign the SRAM index to data
	end
	
	initial begin
		SRAM[10] = 47;
	end
endmodule  