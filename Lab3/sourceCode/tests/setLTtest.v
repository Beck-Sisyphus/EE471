`include "adder_subtractor.v"
`include "flag.v"
`include "mux2_1.sv"
`include "adder16b.v"
`include "adder4b.v"
`include "fullAdder1b.v"
`include "lookAhead4b.v"
`include "subtract.v"
`include "setLT.v"
module setLTtest ();
	// localize variables
	wire [31:0] busADD;
	wire  [31:0] busA, busB;

	// declare an instance of the module
	setLT setLT (busADD, busA, busB);
	// Running the GUI part of simulation
	setLTtester tester (busADD, busA, busB);

	// file for gtkwave

	initial
	begin
		$dumpfile("setLTtest.vcd");
		$dumpvars(1, setLT);
	end

endmodule

module setLTtester (busADD, busA, busB);
	input [31:0] busADD;
	output reg  [31:0] busA, busB;

	parameter d = 20;
	initial // Response
	begin
		$display("busADD \t busA \t busB \t\t\t ");
		#d;
	end

	reg [31:0] i;
	initial // Stimulus
	begin
		$monitor("%b \t %b \t %b \t ", busADD, busA, busB, $time);
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