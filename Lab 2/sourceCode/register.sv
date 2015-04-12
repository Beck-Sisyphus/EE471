module register (
	input clk,    // Clock
	input rst,    // active low reset
	input writeEnable, // Write Enable
	input [31:0] writeData,  // Asynchronous reset active low
	output [31:0] readData
);
	wire [31:0] qBar;
	reg [31:0] out;
	genvar j;

	assign out = (writeEnable) ? writeData : readData;
		
	generate
		for (j = 0; j < 32; j++) begin: registerLoopj
			DFlipFlop registerj (readData[j], qBar[j], readData[j], clk, rst);
		end
	endgenerate
endmodule
