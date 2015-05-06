// active high flags


module addition (busADD, busA, busB, zADD, oADD, cADD, nADD);
	output [31:0] busADD;
	input  [31:0] busA, busB;
	output zADD, oADD, cADD, nADD;
	wire carryOut;
	
	adder_subtractor a1(busADD, busA, busB,1'b0,carryOut);
	
	flag test(busADD, busA, busB, carryOut, zADD, oADD, cADD, nADD);
endmodule

