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





//	decoder8_256 decoder(adx[10:3],indices);
	
//	mux8_1 mux15 (data[15],in0,in1,in2,in3,in4,in5,in6,in7,adx[2],adx[1],adx[0]);
//	mux8_1 mux14 (data[14],in0,in1,in2,in3,in4,in5,in6,in7,adx[2],adx[1],adx[0]);
//	mux8_1 mux13 (data[13],in0,in1,in2,in3,in4,in5,in6,in7,adx[2],adx[1],adx[0]);
//	mux8_1 mux12 (data[12],in0,in1,in2,in3,in4,in5,in6,in7,adx[2],adx[1],adx[0]);
//	mux8_1 mux11 (data[11],in0,in1,in2,in3,in4,in5,in6,in7,adx[2],adx[1],adx[0]);
//	mux8_1 mux10 (data[10],in0,in1,in2,in3,in4,in5,in6,in7,adx[2],adx[1],adx[0]);	
//	mux8_1 mux9 (data[9],in0,in1,in2,in3,in4,in5,in6,in7,adx[2],adx[1],adx[0]);
//	mux8_1 mux8 (data[8],in0,in1,in2,in3,in4,in5,in6,in7,adx[2],adx[1],adx[0]);
//	mux8_1 mux7 (data[7],in0,in1,in2,in3,in4,in5,in6,in7,adx[2],adx[1],adx[0]);	
//	mux8_1 mux6 (data[6],in0,in1,in2,in3,in4,in5,in6,in7,adx[2],adx[1],adx[0]);
//	mux8_1 mux5 (data[5],in0,in1,in2,in3,in4,in5,in6,in7,adx[2],adx[1],adx[0]);
//	mux8_1 mux4 (data[4],in0,in1,in2,in3,in4,in5,in6,in7,adx[2],adx[1],adx[0]);	
//	mux8_1 mux3 (data[3],in0,in1,in2,in3,in4,in5,in6,in7,adx[2],adx[1],adx[0]);	
//	mux8_1 mux2 (data[2],in0,in1,in2,in3,in4,in5,in6,in7,adx[2],adx[1],adx[0]);
//	mux8_1 mux1 (data[1],in0,in1,in2,in3,in4,in5,in6,in7,adx[2],adx[1],adx[0]);
//	mux8_1 mux0 (data[0],in0,in1,in2,in3,in4,in5,in6,in7,adx[2],adx[1],adx[0]);
	
endmodule
