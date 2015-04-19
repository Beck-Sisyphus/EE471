// @requires: a 32 by 32 stack input with each row storing one word
// @returns:  find bits from each column using a 32 to 1 mux, 
//            and form a 32 bit output
module mux32by32_32 (
	output [31:0] out,
	input [31:0] in [31:0],
	input [4:0] sel
);
	genvar i, j;

	generate
		for (j = 0; j < 32; j++) begin: muxLoop
			wire [31:0] bitCompare;
			for (i = 0; i < 32; i++) begin: formARow
				buf e1(bitCompare[i], in[i][j]);
			end
			mux32_1 mux (out[j], bitCompare, sel);
		end
	endgenerate
	
endmodule