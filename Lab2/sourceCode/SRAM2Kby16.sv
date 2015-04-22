<<<<<<< HEAD
// AJ, Beck, and Ray
// SRAM module
// 4/21/15

module SRAM2Kby16(clk, adx, WrEn, data);
	input clk, WrEn;
	input [11:0] adx;
	inout [15:0] data;
=======
module 2Kx16_SRAM(clk,adx,chpSel,ReWr,enable,data);
	input clk;
	input [10:0] adx; // 11 bit address bus
	input chpSel, ReWr, enable;
	inout [15:0] data; //16 bit data bus
	//wire [255:0] indices;
	// A 2K x 16 architecture
	// Word addressable
	// A bidirectional 16 bit Data Bus
	// 11 bit address bus
	// Low true ouput enable
	// Read/Write control. Low true write Enable(~WE) ; High true Read(WE)
	// clock

	reg [2047:0][15:0] sram;
	wire [2047:0] index;
	decoder11_2048 readOne(adx, index);
	
	wire [2047:0] stack;
	wire [2047:0] stackWithMask;
	generate
		genvar i, j;
		for (i = 0; i < 16; i++) begin: Loop
			for (j = 0; j < 16; j++) begin: Loop
				assign stack[j] = sram[j][i];
				// Now we have a stack of 2048 bits in a row
			end
			and mask(stackWithMask, stack, index);
			assign data[i] &= stackWithMask;
		end
	endgenerate




>>>>>>> 2725dc770eddbd4c5890b77ab8d69f2c8faf4b30

	reg [2047:0][15:0] SRAM; // memory regs
	
	assign data = (WrEn) ? SRAM[adx] : 16'bZ; // control the tri-state 
	
	always @(posedge clk) begin
		if(WrEn) 
				SRAM[adx] = data; // assign the SRAM index to data
	end
endmodule 
