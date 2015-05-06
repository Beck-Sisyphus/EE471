// AJ, Beck, and Ray
// ALUnit testbench
// 5/4/15
`include "adder_subtractor.v"
`include "flag.v"
`include "mux2_1.sv"
`include "adder16b.v"
`include "adder4b.v"
`include "fullAdder1b.v"
`include "lookAhead4b.v"
`include "ALUnit.v"
module ALUnittest();

	// localize variables
	wire [31:0] busADD;
	wire  [31:0] busA, busB;
	wire zADD, oADD, cADD, nADD;

	// declare an instance of the module
	ALUnit ALUnit (busADD, busA, busB, zADD, oADD, cADD, nADD);
	// Running the GUI part of simulation
	ALUnittester tester (busADD, busA, busB, zADD, oADD, cADD, nADD);

	// file for gtkwave

	initial
	begin
		$dumpfile("ALUnittest.vcd");
		$dumpvars(1, ALUnit);
	end

endmodule

module ALUnittester (busADD, busA, busB, zADD, oADD, cADD, nADD);
	input [31:0] busADD;
	output reg  [31:0] busA, busB;
	input zADD, oADD, cADD, nADD;

	parameter d = 20;
	initial // Response
	begin
		$display("busADD \t busA \t busB \t\t zADD \t oADD \t cADD \t nADD \t ");
		#d;
	end

	reg [31:0] i;
	initial // Stimulus
	begin
		$monitor("%b \t %b \t %b \t %b \t %b \t %b \t %b", busADD, busA, busB, zADD, oADD, cADD, nADD, $time);
		// positive + positive
		busA = 32'h01010101; busB = 32'h01010101;
		#d;
		busA = 32'h7FFFFFFF; busB = 32'h7FFFFFFF; // should overflow
		#d;
		// positive + negative
		busA = 32'h01010101; busB = 32'hFFFFFFFF; // 01010101 + -1
		#d;
		busA = 32'h00000001; busB = 32'hF0000000;
		#d;
		// negative + positive
		busA = 32'hFFFFFFFF; busB = 32'h01010101;
		#d;
		busA = 32'hF0000000; busB = 32'h00000001;
		#d;
		// negative + negative 
		busA = 32'hFFFFFFFF; busB = 32'hFFFFFFFF; // -1 + -1
		#d;
		busA = 32'h90000000; busB = 32'h80000000; // should overflow
		#d;
		#(3*d);
		$stop; 
		$finish;
	end

endmodule