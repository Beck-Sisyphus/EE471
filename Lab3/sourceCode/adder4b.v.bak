module adder4b(carryIn,X,Y,S,G,P,carryOut);
	input carryIn;
	input [3:0] X;
	input [3:0] Y;
	output [3:0] S;
	wire [3:0] g;
	wire [3:0] p;
	output G;
	output P;
	output [3:0] carryOut;
	wire genCarry;
	fullAdder1b a0(X[0],Y[0],carryIn,g[0],p[0]);
	fullAdder1b a1(X[1],Y[1],genCarry,g[1],p[1]);
	fullAdder1b a2(X[2],Y[2],genCarry,g[2],p[2]);
	fullAdder1b a3(X[3],Y[3],genCarry,g[3],p[3]);
	
	lookAhead4b gen1(carryIn, g,p,G,P,genCarry);






















endmodule
