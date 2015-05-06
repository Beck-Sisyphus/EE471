module InstrucDecoder (
	input  [15:0] instruc, 
	output [2:0]  opcode, 
	output [4:0]  regAdx0, regAdx1
);
	assign opcode = instruc[15:13];
	assign regAdx0= instruc[12:8];
	assign regAdx1= instruc[7:3];
endmodule