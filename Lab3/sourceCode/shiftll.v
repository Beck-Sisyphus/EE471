// a barrel shifter to satisfy the single clock cycle constraint 
// and yet support the multibit shift operation
// @requires: A 32-bit data input, a 32-bit control input;
// @returns:  A 32-bit left shifted output to support shift by 7
module shiftll (busSLL, busA, sel);
	output [31:0] busSLL;
	input  [31:0] busA, sel;

	wire [31:0] Level1, Level2;

	genvar i, j, k;

	// 1-bit shift left
	mux2_1 m00(busSLL[0], Level1[0], 0, sel[0]);

	generate
		for(i = 1; i < 32; i = i+1) begin: Level0Loop
			mux2_1 m0x(busSLL[i], Level1[i], Level1[i-1], sel[0]);
		end
	endgenerate

	// 2-bit shift left
	mux2_1 m10(Level1[0], Level2[0], 0, sel[1]);
	mux2_1 m11(Level1[1], Level2[1], 0, sel[1]);

	generate
		for(j = 2; j < 32; j = j+1) begin: Level1Loop
			mux2_1 m1x(Level1[j], Level2[j], Level2[j-2], sel[1]);
		end
	endgenerate

	// 4-bit shift left
	mux2_1 m20(Level2[0], busA[0], 0, sel[2]);
	mux2_1 m21(Level2[1], busA[1], 0, sel[2]);
	mux2_1 m22(Level2[2], busA[2], 0, sel[2]);
	mux2_1 m23(Level2[3], busA[3], 0, sel[2]);

	generate
		for(k = 4; k < 32; k = k+1) begin: Level2Loop
			mux2_1 m2x(Level2[k], busA[k], busA[k-4], sel[2]);
		end
	endgenerate	

endmodule