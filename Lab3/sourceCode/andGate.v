module andGate (busAND, busA, busB);
	output [31:0] busAND;
	input  [31:0] busA, busB;

	genvar i;
	generate
		for (i = 0; i < 32; i = i + 1) begin: andLoop
			and gateA(busAND[i], busA[i], busB[i]);
		end
	endgenerate

	// flag test(busAND, busA, busB, 1'b0, zAND, oAND, cAND, nAND);
endmodule