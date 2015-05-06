// AJ, Beck, and Ray
// ALUnit testbench
// 5/4/15
`include "Implementation/mux2_1.sv"
`include "adder_subtractor.v"
`include "flag.v"
`include "adder16b.v"
`include "adder4b.v"
`include "fullAdder1b.v"
`include "lookAhead4b.v"
`include "ALUnit.sv"
`include "addition.v"
`include "subtract.v"
`include "andGate.v"
`include "orGate.v"
`include "xorGate.v"
`include "setLT.v"
`include "shiftll.v"
module ALUnittest();

	// localize variables
	wire clk;    // Clock
	wire [2:0]  control;
	wire [31:0] busOut;
	wire  [31:0] busA, busB;
	wire zero, overflow, carryout, negative;

	// declare an instance of the module
	ALUnit ALUnit (clk, control, busOut, busA, busB, zero, overflow, carryout, negative);
	// Running the GUI part of simulation
	ALUnittester tester (clk, control, busOut, busA, busB, zero, overflow, carryout, negative);

	// file for gtkwave

	initial
	begin
		$dumpfile("ALUnittest.vcd");
		$dumpvars(1, ALUnit);
	end

endmodule

module ALUnittester (clk, control, busOut, busA, busB, zero, overflow, carryout, negative);
	output reg clk;    // Clock
	output reg [2:0]  control;
	input [31:0] busOut;
	output reg  [31:0] busA, busB;
	input zero, overflow, carryout, negative;

	parameter d = 20;
	// generate a clock
	always #(d/2) clk = ~clk;
	initial // Response
	begin
		$display("busOut \t busA \t busB \t\t zero \t overflow \t carryout \t negative \t ");
		#d;
	end

	initial
	begin
		$monitor("%b \t %b \t %b \t %b \t %b \t %b \t %b \t %b ", busOut, busA, busB, zero, overflow, carryout, negative, $time);
		// positive + positive
		busA = 32'h01010101; busB = 32'h01010101; control = 3'b000;
		#(10*d);
		busA = 32'h7FFFFFFF; busB = 32'h7FFFFFFF; control = 3'b001;// should overflow
		#(10*d);
		// positive + negative
		busA = 32'h01010101; busB = 32'hFFFFFFFF; control = 3'b010;// 01010101 + -1
		#(10*d);
		busA = 32'h00000001; busB = 32'hF0000000; control = 3'b011;
		#(10*d);
		// negative + positive
		busA = 32'hFFFFFFFF; busB = 32'h01010101; control = 3'b100;
		#(10*d);
		busA = 32'hF0000000; busB = 32'h00000001; control = 3'b101;
		#(10*d);
		// negative + negative 
		busA = 32'hFFFFFFFF; busB = 32'hFFFFFFFF; control = 3'b110;// -1 + -1
		#(10*d);
		busA = 32'h90000000; busB = 32'h80000000; control = 3'b111;// should overflow
		#(10*d);
		#(3*d);
		$stop; 
		$finish;
	end

endmodule