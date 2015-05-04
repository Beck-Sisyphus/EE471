// module itself module in dataflow level, submodule will module in behavioural level
module ALUnit (
	input clk,    // Clock
	//input rst_n,  // Asynchronous reset active low
	input [2:0]  control,
	input [31:0] busA, busB,
	output [31:0] busOut,
	output zero, overflow, carryout, negative
);
	parameter [31:0] nul = 32'b0; // null
	parameter [2:0] NOP = 3'b000, ADD = 3'b001, SUB = 3'b010, AND = 3'b011, OR = 3'b100, XOR = 3'b101, SLT = 3'b110, SLL = 3'b111;
	wire [31:0] busADD, busSUB, busAND, busOR, busXOR, busSLT, busSLL;
	wire zADD, oADD, cADD, nADD, zSUB, oSUB, cSUB, nSUB;
	// present state and next state for zero, overflow, carryout, and negative;
	reg zps, zns, ops, ons, cps, cns, nps, nns;

	assign zero = zps;
	assign overflow = ops;
	assign carryout = cps;
	assign negative = nps;

	addition add1  (busADD, busA, busB, zADD, oADD, cADD, nADD);
	subtract sub1  (busSUB, busA, busB, zSUB, oSUB, cSUB, nSUB);
	andGate  and1  (busAND, busA, busB);
	orGate   or1   (busOR,  busA, busB);
	xorGate  xor1  (busXOR, busA, busB);
	setLT    slt1  (busSLT, busA, busB); // (R[rt] = (R[rs] < R[rt])? 32'b1:32'b0), set less than
	shiftll  sll1  (busSLL, busA, busB); // shift left logical, assuming busB input a 3 bit control signal

	always @(*) begin
		if (control == ADD) begin
			zns = zADD;
			ons = oADD;
			cns = cADD;
			nns = nADD;
		end else if (control == SUB) begin
			zns = zSUB;
			ons = oSUB;
			cns = cSUB;
			nns = nSUB;
		end else begin
			zns = 1'bZ;
			ons = 1'bZ;
			cns = 1'bZ;
			nns = 1'bZ;
		end
	end

	always @(posedge clk) begin
		zps <= zns;
		ops <= ons;
		cps <= cns;
		nps <= nns;
		case(control)
			NOP: busOut <= nul;
			ADD: busOut <= busADD;
			SUB: busOut <= busSUB;
			AND: busOut <= busAND;
			OR:  busOut <= busOR;
			XOR: busOut <= busXOR;
			SLT: busOut <= busSLT;
			SLL: busOut <= busSLL;
			default: busOut <= nul;
		endcase
	end

endmodule
