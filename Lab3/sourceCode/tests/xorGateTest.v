`include "xorGate.v"
module xorGateTest ();
	// localize variables
	wire [31:0] busADD;
	wire  [31:0] busA, busB;

	// declare an instance of the module
	xorGate xorGate (busADD, busA, busB);
	// Running the GUI part of simulation
	xorGatetester tester (busADD, busA, busB);

	// file for gtkwave

	initial
	begin
		$dumpfile("xorGatetest.vcd");
		$dumpvars(1, xorGate);
	end

endmodule

module xorGatetester (busADD, busA, busB);
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