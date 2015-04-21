// EE 471 Lab 1,  Beck Pang, Spring 2015
// Main function for calling different counter onto the board
// @require: only call one counter a time
module DE1_SoC (CLOCK_50, LEDR, SW);
	input 		 CLOCK_50;  // connect to system 50 MHz clock
	output [9:0] LEDR;
	input  [9:0] SW;

	// clock divider
	reg [31:0] tBase;		// system time base
	parameter speed = 24;
	always @(posedge CLOCK_50) 
		tBase <= tBase + 1'b1;

	
endmodule