// active high flags
module addition (busADD, busA, busB, zADD, oADD, cADD, nADD);
	output [31:0] busADD;
	input  [31:0] busA, busB;
	output zADD, oADD, cADD, nADD;
	wire carryOut;
	
	adder_subtractor a1(busADD, busA, busB,1'b0,carryOut);
	
	assign zADD = |busADD; // reduction OR gate
	wire s1, s2;
	xnor part1(s1, busA[31], busB[31]);
	xor  part2(s2, busA[31], busADD[31]);
	and overflow(oADD, s1, s2);
	buf e1(cADD, carryOut);
	buf e2(nADD, busADD[31]);
endmodule