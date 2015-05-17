// a barrel shifter to satisfy the single clock cycle constraint 
// and yet support the multibit shift operation
// @requires: A 32-bit data input, a 32-bit control input;
// @returns:  A 32-bit left shifted output to support shift by 7
module shiftll (busSLL, busA, sel, zSLL, oSLL, cSLL, nSLL);
	output [31:0] busSLL;
	input  [31:0] busA, sel;

    assign busSLL = busA << sel[2:0];

    assign zSLL = ~|busOut[31:0];
    assign nSLL = busOut[31];
    always @(*) begin
    	if (sel[2:0] == 3'b0) begin
    		cSLL = 1'b0;
    		oSLL = 1'b0;
    	end else if (sel[2:0] == 3'b1) begin
    		cSLL = busSLL[31];
    		oSLL = busSLL[31];
    	end else if (sel[3:0] < 4'b1000)begin// if (sel[2:0] == 3'b10)
    		cSLL = busSLL[(31 - sel + 1)];
    		oSLL = |busSLL[31: (31 - sel + 1)];
    	end	else begin
    		cSLL = busSLL[25];
    		oSLL = |busSLL[31:25];
    	end
    	// 	oSLL = |busSLL[31:30]
    	// else if (sel[2:0] == 3'b11)
    	// 	oSLL = |busSLL[31:29]
    	// else if (sel[2:0] == 3'b100)
    	// 	oSLL = |busSLL[31:28]
    	// else if (sel[2:0] == 3'b101)
    	// 	oSLL = |busSLL[31:27]
    	// else if (sel[2:0] == 3'b110)
    	// 	oSLL = |busSLL[31:26]
    	// else
    	// 	oSLL = |busSLL[31:25]
    end
endmodule