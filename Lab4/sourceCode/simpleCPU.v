module simpleCPU (CLOCK_50);
	// ALU control input
	parameter [2:0] NOP = 3'b000, ADD = 3'b001, SUB = 3'b010, AND = 3'b011, OR = 3'b100, XOR = 3'b101, SLT = 3'b110, SLL = 3'b111;

	input CLOCK_50;  // connect to system 50 MHz clock
	reg  WrEn, regWR;
	reg  [10:0] adxData;
	wire [15:0] data;
	reg  [6:0] adxInst;
	wire [31:0] inst;

	reg  [4:0] readAdx0, readAdx1, writeAdx;
	reg  [31:0] writeData;
	wire [31:0] readOutput0, readOutput1;
	
	reg  [2:0] control;
	reg  [31:0] busA, busB;
	wire [31:0] busOut;
	wire zero, overflow, carryout, negative;

	SRAM2Kby16 dataMemory(CLOCK_50, adxData,  WrEn, data);
	InstruMemory InstruMemory(CLOCK_50, adxInst, WrEn, inst);
	registerFile regs(CLOCK_50, readAdx0, readAdx1, writeAdx, regWR, writeData, readOutput0, readOutput1);
	ALUnit logicUnit(CLOCK_50, control, busA, busB, busOut, zero, overflow, carryout, negative);

endmodule