// active high flags

`include "adder_subtractor.v"
`include "flag.v"
`include "mux2_1.sv"
`include "adder16b.v"
`include "adder4b.v"
`include "fullAdder1b.v"
`include "lookAhead4b.v"
module addition (busADD, busA, busB, zADD, oADD, cADD, nADD);
	output [31:0] busADD;
	input  [31:0] busA, busB;
	output zADD, oADD, cADD, nADD;
	wire carryOut;
	
	adder_subtractor a1(busADD, busA, busB,1'b0,carryOut);
	
	flag test(busADD, busA, busB, carryOut, zADD, oADD, cADD, nADD);
endmodule

