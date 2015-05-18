module andGate (busAND, busA, busB);
	output [31:0] busAND;
	input  [31:0] busA, busB;

	assign busAND = busA && busB;

	// flag test(busAND, busA, busB, 1'b0, zAND, oAND, cAND, nAND);
endmodule