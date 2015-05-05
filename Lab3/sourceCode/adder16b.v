module adder16b(X,Y,carryIn,G,P,S);
	input carryIn;
	input [15:0] X;
	input [15:0] Y;
	output G;
	output P;
	output [15:0] S;
	wire [3:0] g;
	wire [3:0] p;
	wire [4:1] c;
	adder4b a0 (X[3:0],  Y[3:0],  carryIn,g[0],p[0],S[3:0]  );
	adder4b a4 (X[7:4],  Y[7:4],  c[1],   g[1],p[1],S[7:4]  );
	adder4b a8 (X[11:8], Y[11:8], c[2],   g[2],p[2],S[11:8] );
	adder4b a12(X[15:12],Y[15:12],c[3],   g[3],p[3],S[15:12]);
	
	lookAhead4b LCU16bit(carryIn, g,p,G,P,c);
endmodule