// AJ, Beck, and Ray
// DE1_SoCPhaseII testbench
// 5/4/15
`include "Implementation/mux2_1.sv"
`include "Implementation/mux4_1.sv"
`include "Implementation/mux8_1.sv"
`include "Implementation/mux32_1.sv"
// `include "Implementation/mux32by32_32.sv"
`include "Implementation/register.sv"
`include "Implementation/registerSingle.sv"
`include "Implementation/DFlipFlop.sv"
`include "Implementation/counter.v"
`include "Implementation/decoder5_32.sv"
`include "Implementation/decoder8_256.sv"
`include "Implementation/decoder11_2048.sv"

`include "adder_subtractor.v"
`include "flag.v"
`include "adder16b.v"
`include "adder4b.v"
`include "fullAdder1b.v"
`include "lookAhead4b.v"
`include "addition.v"
`include "subtract.v"
`include "andGate.v"
`include "orGate.v"
`include "xorGate.v"
`include "setLT.v"
`include "shiftll.v"

`include "DE1_SoCPhaseII.v"
`include "InstrucDecoder.v"
`include "ALUnit.sv"
`include "SRAM2Kby16.v"
`include "registerFile.sv"


// `include "/mux4_1.sv"
// `include "/mux8_1.sv"
// `include "/mux32_1.sv"
// `include "/mux32by32_32.sv"
// `include "/register.sv"
// `include "/registerSingle.sv"
// `include "/DFlipFlop.sv"
// `include "/counter.sv"
// `include "/decoder5_32.sv"
// `include "/decoder8_256.sv"
// `include "/decoder11_2048.sv"

module DE1_SoCPhaseIItest();

	// localize variables
	wire CLOCK_50;  // connect to system 50 MHz clock
	wire [9:0] LEDR;
	wire [9:0] SW;
	wire [3:0] KEY;

	// declare an instance of the module
	DE1_SoCPhaseII DE1_SoCPhaseII (CLOCK_50, LEDR, SW, KEY);
	// Running the GUI part of simulation
	DE1_SoCPhaseIItester tester (CLOCK_50, LEDR, SW, KEY);

	// file for gtkwave

	initial
	begin
		$dumpfile("DE1_SoCPhaseIItest.vcd");
		$dumpvars(1, DE1_SoCPhaseII);
	end

endmodule

module DE1_SoCPhaseIItester (CLOCK_50, LEDR, SW, KEY);
	output CLOCK_50;  // connect to system 50 MHz clock
	input  [9:0] LEDR;
	output [9:0] SW;
	output [3:0] KEY;

	parameter d = 20;
	// generate a clock
	always #(d/2) clk = ~clk;
	initial // Response
	begin
		$display("CLOCK_50 \t LEDR \t SW \t\t KEY \t ");
		#d;
	end

	initial
	begin
		$monitor("%b \t %b \t %b \t %b \t %b \t ", CLOCK_50, LEDR, SW, KEY, $time);
		SW[9] = 1'b1; #d
		SW[9] = 1'b0; #(300*d)
		SW[6] = 1'b1; #(300*d)

		$stop; 
		$finish;
	end

endmodule