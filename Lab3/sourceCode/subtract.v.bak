module subtract (busSUB, busA, busB, zSUB, oSUB, cSUB, nSUB);
	output reg [31:0] busSUB;
	input  [31:0] busA, busB;
	output zSUB, oSUB, cSUB, nSUB;

	wire carryOut;
	
	adder_subtractor a1(busADD, busA, busB,1'b1,carryOut);

	flagTest test(busADD, busA, busB, carryOut, zADD, oADD, cADD, nADD);
endmodule