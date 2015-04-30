module fullAdder1b(x,y,carryIn,G,P);
	input x,y,carryIn;
	output P, G;
	

	assign P = x^y;
	assign G = x*y;


endmodule
