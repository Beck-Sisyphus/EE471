module lookAhead4b(carryIn,g,p,GG,PG,c);
	input carryIn;
	input [3:0] g;
	input [3:0] p;
	output GG,PG;
	output [4:1] c;
	
	wire [3:0] temp;
	//assign c[1] = carryIn * p[0] + g[0];
	and a0(temp[0], carryIn, p[0]);
	or or0(c[1], g[0], temp[0]);
	//assign c[2] = c[1] * p[1] + g[1];
	and a1(temp[1], c[1], p[1]);
	or or1(c[2], g[1], temp[1]);
	//assign c[3] = c[2] * p[2] + g[2];
	and a2(temp[2], c[2], p[2]);
	or or2(c[3], g[2], temp[2]);
	//assign c[4] = c[3] * p[3] + g[3];
	and a3(temp[3], c[3], p[3]);
	or or3(c[4], g[3], temp[3]);
	
	// assign GG = g[3] | (p[3] & g[2]) | (p[3] & p[2] & g[1]) | (p[3] & p[2] & p[1] & g[0]);
	wire [2:0] PP;
	and a01(PP[0], g[0], p[1], p[2], p[3]);
	and a02(PP[1], g[1], p[2], p[3]);
	and a03(PP[2], g[2], p[3]);
	or or4(GG, g[3], PP[2], PP[1], PP[0]);
	
	// assign PG = p[3] * p[2] * p[1] * p[0] ;
	and a11(PG, p[3], p[2], p[1], p[0]);

endmodule
