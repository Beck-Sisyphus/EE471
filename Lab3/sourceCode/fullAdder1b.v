module fullAdder1b(x,y,carryIn,G,P,S);
	input x,y,carryIn;
	output P, G, S;
	
	xor p(P, x, y);
	//assign P = x^y; // x XOR y
	and g(G, x, y);
	//assign G = x*y; // x AND y
	xor s(S, x, y, carryIn);
endmodule
