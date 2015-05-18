// module itself module in dataflow level, submodule will module in behavioural level
module ALUnit (
	input clk,    // Clock
	input [2:0]  control,
	input [31:0] busA, busB,
	output reg [31:0] busOut,
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
			zns = 1'b0;
			ons = 1'b0;
			cns = 1'b0;
			nns = 1'b0;
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

module ALUnit_Testbench();
	reg CLOCK_50;    // Clock
	reg [2:0]  control;
	reg [31:0] busA, busB;
	wire [31:0] busOut;
	wire zero, overflow, carryout, negative;

	ALUnit dut (CLOCK_50, control, busA, busB, busOut, zero, overflow, carryout, negative);
	// Set up the clocking
	
	parameter CLOCK_PERIOD = 100;
	initial CLOCK_50 = 1;
	always begin
		#(CLOCK_PERIOD / 2);
		CLOCK_50 = ~CLOCK_50;
	end 
	

	// Set up the inputs to the design
	integer i;
	initial begin
						      	@(posedge CLOCK_50);
		busA = 32'h01010101; busB = 32'h01010101; control = 3'b000;	
		@(posedge CLOCK_50);
		@(posedge CLOCK_50);
		@(posedge CLOCK_50);
		@(posedge CLOCK_50);
		@(posedge CLOCK_50);
		busA = 32'h7FFFFFFF; busB = 32'h7FFFFFFF; control = 3'b001;	
						      	@(posedge CLOCK_50);
						      	@(posedge CLOCK_50);
		@(posedge CLOCK_50);
		@(posedge CLOCK_50);
		@(posedge CLOCK_50);
		@(posedge CLOCK_50);
		busA = 32'h01010101; busB = 32'hFFFFFFFF; control = 3'b010;
			@(posedge CLOCK_50);
						      	@(posedge CLOCK_50);
		@(posedge CLOCK_50);
		@(posedge CLOCK_50);
		@(posedge CLOCK_50);
		@(posedge CLOCK_50);
		busA = 32'h00000001; busB = 32'hF0000000; control = 3'b011;
		@(posedge CLOCK_50);
		@(posedge CLOCK_50);
		@(posedge CLOCK_50);
		@(posedge CLOCK_50);
		@(posedge CLOCK_50);
		busA = 32'hFFFFFFFF; busB = 32'h01010101; control = 3'b100;
		@(posedge CLOCK_50);
		@(posedge CLOCK_50);
		@(posedge CLOCK_50);
		@(posedge CLOCK_50);
		@(posedge CLOCK_50);
		busA = 32'hF0000000; busB = 32'h00000001; control = 3'b101;
		@(posedge CLOCK_50);
		@(posedge CLOCK_50);
		@(posedge CLOCK_50);
		@(posedge CLOCK_50);
		@(posedge CLOCK_50);
		busA = 32'h00000000; busB = 32'h00000002; control = 3'b110;
		@(posedge CLOCK_50);
		@(posedge CLOCK_50);
		@(posedge CLOCK_50);
		@(posedge CLOCK_50);
		@(posedge CLOCK_50);
		busA = 32'h00000010; busB = 32'h00000034; control = 3'b111;
		@(posedge CLOCK_50);
		@(posedge CLOCK_50);
		@(posedge CLOCK_50);
		@(posedge CLOCK_50);
		@(posedge CLOCK_50);
		$stop;
	end
endmodule 
