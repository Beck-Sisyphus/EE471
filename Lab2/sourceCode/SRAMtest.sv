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
	input clk, WrEn;
	input [11:0] adx;
	inout [15:0] data;
	reg out;
	parameter d = 20;

	// generate a clock
	always #(d/2) clk = ~clk;
	
	assign data = WrEn ? 16'bZ : out;

	initial // Response
	begin
		$display("\t\t clk \t WrEn \t adx \t data  Time ");
		$monitor("\t %b \t %b \t %b \t %b ", clk, WrEn, adx, data, $time);
	end

	always @(posedge clk) // Stimulus
	begin
		WrEn = 1; adx = 0; out = 1;
		#d
		WrEn = 0;
		for(int i = 0; i < 128; i++) begin
			adx = i;
			out = 127 - i;
			#d
		end
		WrEn = 1;
		for(int i = 0; i < 128; i++) begin
			adx = i;
			#d
		end
		#(2*d); // end bias
		$stop; 
		$finish;
	end

endmodule