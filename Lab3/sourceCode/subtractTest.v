// AJ, Beck, and Ray
// subtract testbench
// 5/4/15

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
		busA = 32'h01010101; busB = 32'h01010101; // two positive numbers, do have carryOut
		#(3*d);
		busA = 32'h01010101; busB = 32'hFFFFFFFD; // -3 - 01010101
 		#(3*d);
		busA = 32'hFFFF0101; busB = 32'h0101FFFF;
		#(3*d);
		busA = 32'hFFFFFFFF; busB = 32'hFFFFFFFD;
		#(3*d);
		busA = 32'h7FFFFFFF; busB = 32'h7FFFBBBB; 
		#(3*d);
		$stop; 
		$finish;
	end

endmodule