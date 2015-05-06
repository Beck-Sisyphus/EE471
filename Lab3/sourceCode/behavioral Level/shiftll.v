// a barrel shifter to satisfy the single clock cycle constraint 
// and yet support the multibit shift operation
// @requires: A 32-bit data input, a 32-bit control input;
// @returns:  A 32-bit left shifted output to support shift by 7
module shiftll (busSLL, busA, sel);
	output [31:0] busSLL;
	input  [31:0] busA, sel;

    assign busSLL = busA << sel[2:0];

endmodule