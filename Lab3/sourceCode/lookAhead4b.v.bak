module lookAhead4b(carryIn,g,p,G,P,carryOut);
	input carryIn;
	input [3:0] g;
	input [3:0] p;
	output G,P,carryOut;
	wire [3:0] c;
	
	assign c[0] = carryIn * p[0] + g[0];
	assign c[1] = c[0] * p[1] + g[1];
	assign c[2] = c[1] * p[2] + g[2];
	assign c[3] = c[2] * p[3] + g[3];
	
	assign G = g[3] | (p[3] & g[2]) | (p[3] & p[2] & g[1]) | (p[3] & p[2] & p[1] & g[0]);
	assign P = p[3] * p[2] * p[1] * p[0] ;
	assign carryOut = g[3] | (p[3] & g[2]) | (p[3] & p[2] & g[1]) | (p[3] & p[2] & p[1] & g[0]) | (p[3] & p[2] & p[1] & p[0] &c[0]);
	

endmodule
