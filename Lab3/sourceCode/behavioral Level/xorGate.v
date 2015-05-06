module xorGate (busXOR, busA, busB);
	output [31:0] busXOR;
	input  [31:0] busA, busB;

	assign busXOR = busA ^ busB;

endmodule