// AJ, Beck, and Ray
// subtract testbench
// 5/4/15
`include "adder_subtractor.v"
`include "flag.v"
`include "mux2_1.sv"
`include "adder16b.v"
`include "adder4b.v"
`include "fullAdder1b.v"
`include "lookAhead4b.v"
`include "subtract.v"
module subtracttest();

	// localize variables
	wire [31:0] busADD;
	wire  [31:0] busA, busB;
	wire zADD, oADD, cADD, nADD;

	// declare an instance of the module
	subtract subtract (busADD, busA, busB, zADD, oADD, cADD, nADD);
	// Running the GUI part of simulation
	subtracttester tester (busADD, busA, busB, zADD, oADD, cADD, nADD);

	// file for gtkwave

	initial
	begin
		$dumpfile("subtracttest.vcd");
		$dumpvars(1, subtract);
	end

endmodule

module subtracttester (busADD, busA, busB, zADD, oADD, cADD, nADD);
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
		// positive - positive
		busA = 32'h01010101; busB = 32'h01010101; // should have carryOut
		#d;
		busA = 32'h7FFFFFF0; busB = 32'h7FFFFFFF;
		#d;
		// positive - negative
		busA = 32'h00000001; busB = 32'hFFFFFFFF; // 1 - -1
		#d;
		busA = 32'h70000000; busB = 32'hF0000000; // should overflow
		#d;
		// negative - positive
		busA = 32'hFFFFFFFF; busB = 32'h00000001;
		#d;
		busA = 32'h90000000; busB = 32'h70000000; // should overflow
		#d;
		// negative - negative 
		busA = 32'hFFFFFFFF; busB = 32'hFFFFFFFF;
		#d;
		busA = 32'hF0000000; busB = 32'hF0000000;
		#d;
		#(3*d);
		$stop; 
		$finish;
	end

endmodule