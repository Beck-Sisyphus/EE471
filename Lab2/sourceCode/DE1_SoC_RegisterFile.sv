// EE 471 Lab 1,  Beck Pang, Spring 2015
// Main function for calling different counter onto the board
// @require: only call one counter a time
module DE1_SoC_RegisterFile (CLOCK_50, LEDR, SW);
	input 		 CLOCK_50;  // connect to system 50 MHz clock
	output [9:0] LEDR;
	input  [9:0] SW;

	// clock divider
	reg [31:0] slowClock;		// system time base
	parameter speed = 24;
	always @(posedge CLOCK_50) 
		slowClock <=	slowClock + 1'b1;
	
	assign LEDR = 10'h0F0;
// 	registerFile reg0(slowClock, 
// 	input [4:0] regReadSel0, regReadSel1, regWriteSel,
// 	input writeEnable, // Write Enable
// 	input [31:0] writeData, 
// 	output [31:0] regReadData0, regReadData1
// );
	
endmodule