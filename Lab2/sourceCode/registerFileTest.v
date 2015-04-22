// Beck Pang
// University of Washington, Seattle
// Apr. 6th, 2015
// EE 471, Lab 1

`include "decoder5_32.sv"
`include "register.sv"
`include "mux32by32_32.sv"
`include "registerFile.sv"
// test bench running on gtkwave
module registerFile_testBench ();

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
		$dumpvars(1, myCounter);
	end

endmodule

module registerFile_Tester (
	output reg clk, 
	output reg [4:0] regReadSel0, regReadSel1, regWriteSel,
	output reg writeEnable, // Write Enable
	output reg [31:0] writeData, 
	input [31:0] regReadData0, regReadData1
);

	parameter stimDelay = 20;

	// generate a clock
	always #(stimDelay/2) clk = ~clk;

	initial // Response
	begin
		$display("\t\t clk writeEnable \t   Time ");
		$monitor("\t %b ", regReadData0, $time);
		$monitor("\t %b ", regReadData1, $time);
		clk = 'b0;
	end

	always @(posedge clk) // Stimulus
	begin
					writeEnable = 1'b1;
		// A full cycle to write
		#stimDelay	writeEnable = 1'b1; 
		#stimDelay	regWriteSel = 5'b00000; 
		#stimDelay	writeData   = 32'hFFFF000F; 
		// Writing period
		#(10*stimDelay)	writeEnable = 5'b0; 
		#stimDelay	writeEnable = 5'b1;
		#stimDelay	writeData   = 5'bZ;  

		// #(32*stimDelay)  writeEnable = 'b0;
		// #stimDelay  clk = 'b1;
		// #(32*stimDelay)  clk = 'b0;
		// #stimDelay  clk = 'b1;
		// #(2*stimDelay);
		$stop;
		$finish;
	end

endmodule