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
	
	mux8_1 mux15 (data[15],in0,in1,in2,in3,in4,in5,in6,in7,adx[2],adx[1],adx[0]);
	mux8_1 mux14 (data[14],in0,in1,in2,in3,in4,in5,in6,in7,adx[2],adx[1],adx[0]);
	mux8_1 mux13 (data[13],in0,in1,in2,in3,in4,in5,in6,in7,adx[2],adx[1],adx[0]);
	mux8_1 mux12 (data[12],in0,in1,in2,in3,in4,in5,in6,in7,adx[2],adx[1],adx[0]);
	mux8_1 mux11 (data[11],in0,in1,in2,in3,in4,in5,in6,in7,adx[2],adx[1],adx[0]);
	mux8_1 mux10 (data[10],in0,in1,in2,in3,in4,in5,in6,in7,adx[2],adx[1],adx[0]);	
	mux8_1 mux9 (data[9],in0,in1,in2,in3,in4,in5,in6,in7,adx[2],adx[1],adx[0]);
	mux8_1 mux8 (data[8],in0,in1,in2,in3,in4,in5,in6,in7,adx[2],adx[1],adx[0]);
	mux8_1 mux7 (data[7],in0,in1,in2,in3,in4,in5,in6,in7,adx[2],adx[1],adx[0]);	
	mux8_1 mux6 (data[6],in0,in1,in2,in3,in4,in5,in6,in7,adx[2],adx[1],adx[0]);
	mux8_1 mux5 (data[5],in0,in1,in2,in3,in4,in5,in6,in7,adx[2],adx[1],adx[0]);
	mux8_1 mux4 (data[4],in0,in1,in2,in3,in4,in5,in6,in7,adx[2],adx[1],adx[0]);	
	mux8_1 mux3 (data[3],in0,in1,in2,in3,in4,in5,in6,in7,adx[2],adx[1],adx[0]);	
	mux8_1 mux2 (data[2],in0,in1,in2,in3,in4,in5,in6,in7,adx[2],adx[1],adx[0]);
	mux8_1 mux1 (data[1],in0,in1,in2,in3,in4,in5,in6,in7,adx[2],adx[1],adx[0]);
	mux8_1 mux0 (data[0],in0,in1,in2,in3,in4,in5,in6,in7,adx[2],adx[1],adx[0]);
	
endmodule
