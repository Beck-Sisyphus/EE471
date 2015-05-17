module orGate (busOR,  busA, busB, zOR, oOR, cOR, nOR);
	output [31:0] busOR;
	input  [31:0] busA, busB;

	assign busOR = busA | busB;

	wire o_;
	flag test(busAND, busA, busB, 1'b0, zOR, o_, cOR, nOR);
	assign oOR = 1'b0;
endmodule