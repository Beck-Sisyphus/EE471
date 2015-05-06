module flag (
	input [31:0] busOut, busA, busB, 
	input carryOut, 
	output z, o, c, n
);
	wire tempZ[7:0];
	// NOR gate will act 1 when all inputs are 0
	// assign z = ~|busOut[31:0];
	genvar i;
	generate
		for (i = 0; i < 8; i = i+1) begin: zeroLoop
			nor zero0(tempZ[i], busOut[0 + 4 * i], busOut[1 + 4 * i],busOut[2 + 4 * i],busOut[3 + 4 * i]);
		end
	endgenerate

	and zero8(z, tempZ[0], tempZ[1], tempZ[2], tempZ[3], tempZ[4], tempZ[5], tempZ[6], tempZ[7]);

	wire s1, s2;
	xnor part1(s1, busA[31], busB[31]);
	xor  part2(s2, busA[31], busOut[31]);
	and overflow(o, s1, s2);
	buf e1(c, carryOut);
	buf e2(n, busOut[31]);

endmodule