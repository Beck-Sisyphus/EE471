// A - B
module adder_subtractor(S, busA, busB,sel,carryOut);
	input [31:0] busA, busB;
	input sel;
	output [31:0]S;
	output carryOut;
	wire [31:0] selB;
	wire [31:0] notB;
	wire [1:0] g;
	wire [1:0] p;
	wire c;
	
	genvar i;
	generate
		for (i = 0; i < 32; i = i+1) begin: AddorSubtract
			nor n1(notB[i], busB[i]);
			mux2_1 choose1(selB[i], busB[i], notB[i], sel);
		end
	endgenerate
	
	adder16b a0 (busA[15:0], selB[15:0] , sel,g[0],p[0],S[15:0] );
	adder16b a16(busA[31:16],selB[31:16],  c ,g[1],p[1],S[31:16]);
	
	assign c        = sel * p[0] + g[0];
	assign carryOut = c   * p[1] + g[1];

endmodule