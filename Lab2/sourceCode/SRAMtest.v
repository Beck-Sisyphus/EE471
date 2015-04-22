// AJ, Beck, and Ray
// SRAM testbench
// 4/21/15

`include "SRAM2Kby16.v"
module SRAMtest();

	// localize variables
	wire clk, WrEn;
	wire [10:0] adx;
	wire [15:0] data;

	// declare an instance of the module
	SRAM2Kby16 SRAM (clk, adx, WrEn, data);

	// Running the GUI part of simulation
	SRAMtester tester (clk, adx, WrEn, data);

	// file for gtkwave

	initial
	begin
		$dumpfile("SRAMtest.vcd");
		$dumpvars(1, SRAM);
	end

endmodule

module SRAMtester (clk, adx, WrEn, data);
	output reg [10:0] adx;
	inout [15:0] data;
	output reg clk, WrEn;
	reg [15:0] out;
	parameter d = 20;

	// generate a clock
	always #(d/2) clk = ~clk;
	
	assign data = WrEn ? 16'bZ : out;

	initial // Response
	begin
		$display("clk \t WrEn \t adx \t\t data \t\t out Time ");
		#d;
		clk = 0;
	end

	reg [31:0] i;
	initial // Stimulus
	begin
		$monitor("%b \t %b \t %b \t %b", clk, WrEn, adx, data, $time);
		WrEn = 1; adx = 0; out = 0;
		#(10*d)
		WrEn = 0;
		for(i = 0; i < 128; i = i + 1) begin
			adx = i;
			out = 127 - i;
			#d;
		end
		WrEn = 1;
		for(i = 0; i < 128; i = i + 1) begin
			adx = i;
			#d;
		end
		#(2*d); // end bias
		$stop; 
		$finish;
	end

endmodule