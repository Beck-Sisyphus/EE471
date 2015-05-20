// EE 471 Lab 4, Beck Pang, Spring 2015
// four 4-word block directly mapped cache with write back method
// Instruction cache, only need to read instruction
// but the cache is a general cache
module dCache (
	input clk,    // Clock
	input rst_n,  // Asynchronous reset active low
	input WrEn,
	input [31:0] dataIn,        // Data from memory
	input [10:0] adxIn,			// Address from ALU
	output [31:0] dataOutHigh,  // Data write up to register files
);
	parameter DATA_WIDTH = 32;
	wire [15:0] dataOutLow;		// Data write down to memory
	wire [10:0] adxBlock; 		// Block address for moving a 4-word block from the memory to cache
	reg [1:0] valid, dirty;
	reg [6:0] tag [1:0];
	reg [127:0]CACH [1:0];
	wire [1:0] index;
	wire [6:0] tagIn;
	wire [1:0] offset;
	wire MemWrEn;

	SRAM2Kby16 dataMemory(clk, adxBlock, MemWrEn, dataOutLow);
	assign offset= adxIn[1:0] ;
	assign index = adxIn[3:2] ; // 7 bit tag, 2 bit index, 2 bit offset
	assign tagIn = adxIn[10:4];

	// In read operation, WrEn == 1'b0
	//	  If cache hit, return value
	//    else, 
	//		find the index
	//		If dirty, dataOutLow write 
	//		Read data from DRAM
	//		clear the dirty bit to 1'b0
	//		dataOutReg write
	always @(*)	begin
		if (WrEn == 1'b0)	begin
			if (tag[index] == tagIn) 	begin // cache hit
				MemWrEn     = 1'b1;
				dataOutLow 	= 16'bZ;
			end else 					begin
				if(dirty[index]) begin
					// Write to Memory
				end
				// read data from DRAM into the cache
				dirty[index] = 1'b0;
			end
			dataOutHigh = CACH[index][(32 * index + 31) -: 31];
		end else			begin
			dataOutHigh = 32'bZ;
			if (tag[index] != tagIn)	begin
				if(dirty[index])		begin
					// Write to Memory
				end
				// read data from DRAM into the cache
			end
			CACH[index][(32 * index + 31) -: 31] = dataIn;
			dirty[index] = 1'b1;
		end
	end
	// In write operation, WrEn == 1'b1
	//	  If cache not hit,
	//		find the index
	//		If dirty, dataOutMem write 
	//		Read data from DRAM
	//	  Always do,
	//		write the new data into the cache block
	//		Dirty bit to 1'b1


endmodule