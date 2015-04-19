module 2Kx16_SRAM(clk,adx,chpSel,OutEn,WrEn,data);
	input clk;
	input [11:0] adx;
	input chpSel;
	input OutEn;
	input WrEn;
	inout [15:0] data;
	wire [255:0] indices;
	// A 2K x 16 architecture
	// Word addressable
	// A bidirectional 16 bit Data Bus
	// 11 bit address bus
	// Low true ouput enable
	// Read/Write control. Low true write Enable(~WE) ; High true Read(WE)
	// clock
	decoder8_256 decoder(adx[10:3],indices);
	
	mux8_1 mux15 (out[15],in0,in1,in2,in3,in4,in5,in6,in7,adx[2],adx[1],adx[0]);
	mux8_1 mux14 (out[14],in0,in1,in2,in3,in4,in5,in6,in7,adx[2],adx[1],adx[0]);
	mux8_1 mux13 (out[13],in0,in1,in2,in3,in4,in5,in6,in7,adx[2],adx[1],adx[0]);
	mux8_1 mux12 (out[12],in0,in1,in2,in3,in4,in5,in6,in7,adx[2],adx[1],adx[0]);
	mux8_1 mux11 (out[11],in0,in1,in2,in3,in4,in5,in6,in7,adx[2],adx[1],adx[0]);
	mux8_1 mux10 (out[10],in0,in1,in2,in3,in4,in5,in6,in7,adx[2],adx[1],adx[0]);	
	mux8_1 mux9 (out[9],in0,in1,in2,in3,in4,in5,in6,in7,adx[2],adx[1],adx[0]);
	mux8_1 mux8 (out[8],in0,in1,in2,in3,in4,in5,in6,in7,adx[2],adx[1],adx[0]);
	mux8_1 mux7 (out[7],in0,in1,in2,in3,in4,in5,in6,in7,adx[2],adx[1],adx[0]);	
	mux8_1 mux6 (out[6],in0,in1,in2,in3,in4,in5,in6,in7,adx[2],adx[1],adx[0]);
	mux8_1 mux5 (out[5],in0,in1,in2,in3,in4,in5,in6,in7,adx[2],adx[1],adx[0]);
	mux8_1 mux4 (out[4],in0,in1,in2,in3,in4,in5,in6,in7,adx[2],adx[1],adx[0]);	
	mux8_1 mux3 (out[3],in0,in1,in2,in3,in4,in5,in6,in7,adx[2],adx[1],adx[0]);	
	mux8_1 mux2 (out[2],in0,in1,in2,in3,in4,in5,in6,in7,adx[2],adx[1],adx[0]);
	mux8_1 mux1 (out[1],in0,in1,in2,in3,in4,in5,in6,in7,adx[2],adx[1],adx[0]);
	mux8_1 mux15 (out[0],in0,in1,in2,in3,in4,in5,in6,in7,adx[2],adx[1],adx[0]);
	
endmodule
