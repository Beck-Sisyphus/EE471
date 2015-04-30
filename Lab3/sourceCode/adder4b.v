module adder4b(carryIn,X,Y,S,G,P,carryOut);
	input carryIn;
	input [4:0] X;
	input [4:0] Y;
	output [4:0] S;
	wire [4:0] g;
	wire [4:0] p;
	output G;
	output P;
	output [4:0] carryOut;

	fullAdder1b a0(X[0],Y[0],carryOut,g[0],p[0]);
	fullAdder1b a1(X[1],Y[1],carryOut,g[1],p[1]);
	fullAdder1b a2(X[2],Y[2],carryOut,g[2],p[2]);
	fullAdder1b a3(X[3],Y[3],carryOut,g[3],p[3]);
	
	lookAhead4b(carryIn, g,p,G,P,carryOut);






















endmodule
