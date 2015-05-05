module orGate (busOR,  busA, busB);
	output [31:0] busOR;
	input  [31:0] busA, busB;
	genvar i;
	generate
		for (i = 0; i < 32; i = i + 1) begin: orLoop
			or gateA(busXOR[i], busA[i], busB[i]);
		end
	endgenerate
endmodule