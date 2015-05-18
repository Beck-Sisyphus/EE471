module hexOnHex (data, conv);
	input [3:0] data;
	output reg [6:0] conv;
	
	always @(*) begin
		case (data)
			0: conv = 7'b1000000;
			1: conv = 7'b1111001;
<<<<<<< HEAD
 		   2: conv = ~7'b1011011;
			3: conv = ~7'b1001111;
			4: conv = ~7'b1100110;
			5: conv = ~7'b1101101;
=======
 		  	2: conv = 7'b1011011;
			3: conv = 7'b1001111;
			4: conv = 7'b1100110;
			5: conv = 7'b1101101;
>>>>>>> 4ef52fa02454baa96b0d94c2cbe2338cd61ba0d6
			6: conv = 7'b0000010;
			7: conv = 7'b1111000;
			8: conv = 7'b0000000;
			9: conv = 7'b0011000;
			10: conv = 7'b0001000;
			11: conv = 7'b0000011;
			12: conv = 7'b0100111;
			13: conv = 7'b0100001;
			14: conv = 7'b0000110;
			15: conv = 7'b0001110;
		endcase
end
endmodule 
