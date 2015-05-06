// logical set less than
// @requires: Two 32 bit signed 2's complemented, a completed subtract module 
// @returns: (R[rt] = (R[rs] < R[rt])? 32'b1:32'b0), set less than
module setLT (busSLT, busA, busB);
	output [31:0] busSLT;
	input  [31:0] busA, busB;
	wire zSUB, oSUB, cSUB, nSUB;

	wire [31:0] busSUB;

	// use sign extension assign busSLT[31:1] = 30'b0;
	subtract sub1(busSUB, busA, busB, zSUB, oSUB, cSUB, nSUB);
	// buf e2(busSLT[0], busSUB[31]);
	assign busSLT[31:0] = {31'b0, busSUB[31]};
endmodule