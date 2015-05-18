// logical set less than
// @requires: Two 32 bit signed 2's complemented, a completed subtract module 
// @returns: (R[rt] = (R[rs] < R[rt])? 32'b1:32'b0), set less than
module setLT (busSLT, busA, busB);
	output [31:0] busSLT;
	input  [31:0] busA, busB;
	wire zSUB, oSUB, cSUB, nSUB;

	wire [31:0] busSUB;

	assign busSLT = (busA < busB) ? 32'b1:32'b0;
endmodule