module xorGate (busXOR, busA, busB, zXOR, oXOR, cXOR, nXOR);
	output [31:0] busXOR;
	input  [31:0] busA, busB;

	assign busXOR = busA ^ busB;

	wire o_;
	flag test(busAND, busA, busB, 1'b0, zXOR, o_, cXOR, nXOR);
	assign oXOR = 1'b0;
endmodule