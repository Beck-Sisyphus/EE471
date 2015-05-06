`include "mux2_1.sv"
`include "shiftll.v"
module shiftllTest ();
	// localize variables
	wire [31:0] busADD;
	wire  [31:0] busA, busB;

	// declare an instance of the module
	shiftll shiftll (busADD, busA, busB);
	// Running the GUI part of simulation
	shiftlltester tester (busADD, busA, busB);

	// file for gtkwave

	initial
	begin
		$dumpfile("shiftlltest.vcd");
		$dumpvars(1, shiftll);
	end

endmodule

module shiftlltester (busADD, busA, busB);
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
		busA = 32'h01010101; busB = 32'h00000001;
		#d;
		busA = 32'h01010101; busB = 32'h00000002;
		#d;
		busA = 32'h01010101; busB = 32'h00000003;
		#d;
		busA = 32'h01010101; busB = 32'h00000004;
		#d;
		busA = 32'h01010101; busB = 32'h00000005;
		#d;
		busA = 32'h01010101; busB = 32'h00000006;
		#d;
		busA = 32'h01010101; busB = 32'h00000007; 
		#d;
		busA = 32'h01010101; busB = 32'h0000000F; 
		#d;
		#(3*d);
		$stop; 
		$finish;
	end

endmodule