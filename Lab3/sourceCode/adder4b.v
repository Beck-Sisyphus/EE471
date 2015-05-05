module adder4b(X,Y,carryIn,G,P,S);
	input carryIn;
	input [3:0] X;
	input [3:0] Y;
	output G;
	output P;
	output [3:0] S;
	wire [3:0] g;
	wire [3:0] p;
	wire [4:1] c;
	fullAdder1b a0(X[0],Y[0],carryIn,g[0],p[0],S[0]);
	fullAdder1b a1(X[1],Y[1],c[1],   g[1],p[1],S[1]);
	fullAdder1b a2(X[2],Y[2],c[2],   g[2],p[2],S[2]);
	fullAdder1b a3(X[3],Y[3],c[3],   g[3],p[3],S[3]);
	
	lookAhead4b LCU4bit(carryIn, g,p,G,P,c);
endmodule
