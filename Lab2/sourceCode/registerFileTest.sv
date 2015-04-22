// Beck Pang
// University of Washington, Seattle
// Apr. 6th, 2015
// EE 471, Lab 1

`include "registerFile.sv"
`include "decoder5_32.sv"
`include "register.sv"
`include "registerSingle.sv"
`include "mux32_1.sv"
`include "mux8_1.sv"
`include "mux4_1.sv"
`include "mux2_1.sv"
`include "DFlipFlop.sv"
// test bench running on gtkwave
module registerFile_testBench();

	// connext the two modules
	wire clk;
	wire [4:0] regReadSel0, regReadSel1, regWriteSel;
	wire writeEnable; // Write Enable
	wire [31:0] writeData; 
	wire [31:0] regReadData0, regReadData1;

	// declare an instance of the AND module
	registerFile registerList (clk, regReadSel0, regReadSel1, regWriteSel,
	 writeEnable, writeData, regReadData0, regReadData1);

	// Running the GUI part of simulation
	registerFile_Tester aTester (clk, regReadSel0, regReadSel1, regWriteSel,
	 writeEnable, writeData, regReadData0, regReadData1);

	// file for gtkwave

	initial
	begin
		$dumpfile("registerFile.vcd");
		$dumpvars(1, registerList);
	end

endmodule

module registerFile_Tester (
	output reg clk, 
	output reg [4:0] regReadSel0, regReadSel1, regWriteSel,
	output reg writeEnable, // Write Enable
	output [31:0] writeData, 
	input [31:0] regReadData0, regReadData1
);
	reg [31:0] newWriteData;
	parameter stimDelay = 20;

	// generate a clock
	always #(stimDelay/2) clk = ~clk;

	assign writeData = writeEnable ? 16'bZ : newWriteData;

	initial // Response
	begin
		$display("\t\t clk \t writeEnable \t regReadSel0 \t regReadSel1 \t regWriteSel \t writeData \t regReadData0 \t regReadData1 \t  Time ");
		$monitor("\t %b ", writeData, $time);
		$monitor("\t %b \t %b ", clk, writeEnable, $time);
		$monitor("\t %b \t %b ", regReadData0, regReadData1, $time);
		$monitor("\t %b \t %b \t %b",regReadSel0, regReadSel1, regWriteSel , $time);
		clk = 'b0;
	end

	reg [4:0] i, j;
	always @(posedge clk) // Stimulus
	begin
					writeEnable = 1'b1;
		// A full cycle to write
		writeEnable = #stimDelay 1'b1; 
		writeEnable = #stimDelay 1'b0;
		regReadSel0 = 5'b00000;
		regReadSel1 = 5'b00011; 
		for (i = 0; i < 16; i = i + 1) begin
			regWriteSel = 5'b00000 + i; 
			newWriteData  = 32'hFFFF000F - i;
			#stimDelay;
		end
		writeEnable = 5'b1; #(20*stimDelay); 
		writeEnable = 5'b0; #stimDelay;

		for (j = 0; j < 16; j = j + 1) begin
			regWriteSel = 5'b10000 + j; 
			newWriteData   = 32'h0000FFF0 + j; 
			#stimDelay;
		end
		writeEnable = 5'b1; #stimDelay; 
		writeEnable = 5'b1; #(20*stimDelay); 

		$stop;
		$finish;
	end

endmodule