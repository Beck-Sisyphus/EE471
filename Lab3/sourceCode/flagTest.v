module flagTest (
	input [31:0] busOut, busA, busB, 
	input carryOut, 
	output z, o, c, n
);
	genvar i;
	reg tempZ;
	generate
		for (i = 0; i < 32; i = i+1) begin: zeroLoop
			or z(tempZ, busOut[i]);
		end
	endgenerate
	buf e0(z, tempZ);

	wire s1, s2;
	xnor part1(s1, busA[31], busB[31]);
	xor  part2(s2, busA[31], busOut[31]);
	and overflow(o, s1, s2);
	buf e1(c, carryOut);
	buf e2(n, busOut[31]);

endmodule