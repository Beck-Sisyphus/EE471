module 2Kx16_SRAM_Beck_Version(clk,adx,chpSel,OutEn,WrEn,data);
	input clk;
	input [10:0] adx;
	input chpSel;
	input OutEn;
	input WrEn;
	//inout [15:0] data;

	// First implement read only
	output [15:0] data;
	
	reg [2047:0][15:0] SRAM;
	wire [2047:0] readBit;
	decoder11_2048 readOne(adx, readBit);

	genvar i, j;
	generate
		for (i = 0; i < 16; i++) begin: Loop
			wire [2047:0] stack;
			wire [2047:0] stackWithMask;
			for (j = 0; j < 16; j++) begin: Loop
				assign stack[j] = SRAM[j][i];
				// Now we have a stack of 2048 bits in a row
			end
			and mask(stackWithMask, stack, readBit);
			assign data[i] = &stackWithMask;
		end
	endgenerate


endmodule