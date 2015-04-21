// It's an unit in a synchronous memory system, 32-bit wide.
// @requires: a clock signal, a reset signal, a low signal for write enable,
//            a 32-bit array of data to write
// @modifies: When write enabled, register replaces its data array with the passed in data
//            in the positive or negative edge of the clock
// @returns:  When write disabled, register output the data stored in the register.
module register (
	input clk,
	input rst,    // active low reset
	input writeEnable, // Write Enable
	input [31:0] writeData,  // Asynchronous reset active low
	output [31:0] readData
);
	wire [31:0] qBar;
	reg [31:0] out;
	genvar j;
// NEED TO CHANGE OPTION to GATE LEVEL
	buf e1(out, ((writeEnable) ? writeData : readData)); 
		
	generate
		for (j = 0; j < 32; j = j + 1) begin: registerLoopj
			DFlipFlop registerj (readData[j], qBar[j], readData[j], clk, rst);
		end
	endgenerate
endmodule
