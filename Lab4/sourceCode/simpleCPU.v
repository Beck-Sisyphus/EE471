module simpleCPU (clk, rst, IMR, instr2load, loadAdx);
	// ALU control input
	

	input clk, rst, IMR;	// connect to system 50 MHz clock
	input [31:0] instr2load;
	input [6:0] loadAdx;
	
	wire  MemWrEn, regWR, zero, overflow, carryout, negative, Mem2Reg, ALUop, ALUsrc, writeSel;
	wire  [10:0] adxData;
	wire [31:0] imd;
	wire [15:0] data;
	wire  [4:0] regAdx1, regAdx2, writeAdx;
	wire  [31:0] writeData;
	wire [31:0] readOutput1, readOutput2;
	wire  [2:0] control;
	wire  [31:0] busA, busB;
	wire [31:0] busOut;
	wire [5:0] opCode;

	registerFile regs(clk, regAdx1, regAdx2, writeAdx, regWR, writeData, readOutput1, readOutput2);
	ALUnit logicUnit(control, busA, busB, busOut, zero, overflow, carryout, negative);
	SRAM2Kby16 dataMemory(clk, adxData, MemWrEn, data);

	CPUcontrol controlFlow(clk, rst, negative, IMR, instr2load, loadAdx, regWR, Mem2Reg, ALUop, MemWrEn, ALUsrc, writeSel, regAdx1, regAdx2, writeAdx, imd);

	assign busA = readOutput1;
	//mux2_1 busBinput(busB, readOutput2, imd, ALUSrc);
	
	assign busB = ALUsrc ? imd : readOutput2;

	wire [31:0] readDataSE; // sign extended output from SRAM
	assign readDataSE = {{16{data[15]}}, data};
	mux2_1 Mem2Register(writeData, busOut, readDataSE, Mem2Reg);

	// Store word operation
	assign adxData = busOut[10:0]; // Only care the busOut at store word operation
	assign data = MemWrEn ? 16'bZ : readOutput2[15:0]; // When store word, the data comes from the register file

	ALUcontrol translate(ALUop, imd[5:0], control);
	
endmodule
