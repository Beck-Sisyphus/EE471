module xorGate (busXOR, busA, busB);
	output [31:0] busXOR;
	input  [31:0] busA, busB;
	genvar i;
	generate
		for (i = 0; i < 32; i = i + 1) begin: xorLoop
			xor gateA(busXOR[i], busA[i], busB[i]);
		end
	endgenerate
endmodule