// active high flags


module subtract (busSUB, busA, busB, zSUB, oSUB, cSUB, nSUB);
	output [31:0] busSUB;
	input  [31:0] busA, busB;
	output zSUB, oSUB, cSUB, nSUB;

	wire carryOut;
	
	adder_subtractor a1(busSUB, busA, busB,1'b1,carryOut);

	flag test(busSUB, busA, busB, carryOut, zSUB, oSUB, cSUB, nSUB);
endmodule