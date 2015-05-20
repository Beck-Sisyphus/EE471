module InstrucDecoder (instr[31:26],RegDst, j, br,Mem2Reg,ALUop,MemWrEn,ALUsrc,writeSel);

input [31:26] instr;
output reg RegDst,j, br,Mem2Reg,ALUop,MemWrEn,ALUsrc,writeSel;

parameter nop=6'b101100,add=6'b100000, sub=6'b100010, AND=6'b100100, OR=6'b100101, XOR=6'b100110, slt=6'b101010,
				sll=6'b000000, lw=6'b100011, sw=6'b101011, j=6'b000010, jr=6'b001000, bgt=6'b101101;

always @(*)
	begin
		case(instr)
			nop:	begin
						RegDst = 1;
						j = 0;
						br = 0;
						Mem2Reg = 0;
						ALUop = 1;
						MemWrEn = 0;
						ALUsrc = 0;
						writeSel = 0;
						end
			add:	begin
						RegDst = 1;
						j = 0;
						br = 0;
						Mem2Reg = 0;
						ALUop = 1;
						MemWrEn = 0;
						ALUsrc = 0;
						writeSel = 1;
						end
			sub:	begin
						RegDst = 1;
						j = 0;
						br = 0;
						Mem2Reg = 0;
						ALUop = 1;
						MemWrEn = 0;
						ALUsrc = 0;
						writeSel = 1;
						end
			AND:	begin
						RegDst = 1;
						j = 0;
						br = 0;
						Mem2Reg = 0;
						ALUop = 1;
						MemWrEn = 0;
						ALUsrc = 0;
						writeSel = 1;
						end
			OR:		begin
						RegDst = 1;
						j = 0;
						br = 0;
						Mem2Reg = 0;
						ALUop = 1;
						MemWrEn = 0;
						ALUsrc = 0;
						writeSel = 1;
						end
			XOR:	begin
						RegDst = 1;
						j = 0;
						br = 0;
						Mem2Reg = 0;
						ALUop = 1;
						MemWrEn = 0;
						ALUsrc = 0;
						writeSel = 1;
						end
			slt:	begin
						RegDst = 1;
						j = 0;
						br = 0;
						Mem2Reg = 0;
						ALUop = 1;
						MemWrEn = 0;
						ALUsrc = 0;
						writeSel = 1;
						end
			sll:	begin
						RegDst = 1;
						j = 0;
						br = 0;
						Mem2Reg = 0;
						ALUop = 1;
						MemWrEn =0;
						ALUsrc = 0;
						writeSel = 1;
						end
			lw:		begin
						RegDst = 0;
						j = 0;
						br = 0;
						Mem2Reg = 1;
						ALUop = 0;
						MemWrEn = 1;
						ALUsrc = 1;
						writeSel = 0;
						end
			sw:		begin
						RegDst = 0;
						j = 0;
						br = 0;
						Mem2Reg = 1;
						ALUop = 0;
						MemWrEn = 1;
						ALUsrc = 1;
						writeSel = 0;
						end
			j:		begin
						RegDst = 0;
						j = 1;
						br = 0;
						Mem2Reg = 1;
						ALUop = 0;
						MemWrEn = 0;
						ALUsrc = 1;
						writeSel = 0;
						end
			jr:		begin
						RegDst = 0;
						j = 1;
						br = 0;
						Mem2Reg = 1;
						ALUop = 0;
						MemWrEn = 0;
						ALUsrc = 1;
						writeSel = 0;
						end
			bgt:	begin
						RegDst = 0;
						j = 0;
						br = 1;
						Mem2Reg = 1;
						ALUop = 0;
						MemWrEn = 0;
						ALUsrc = 1;
						writeSel = 0;
						end
			default:
						RegDst = 1'bx;
						j = 1'bx;
						br = 1'bx;
						Mem2Reg = 1'bx;
						ALUop = 1'bx;
						MemWrEn = 1'bx;
						ALUsrc = 1'bx;
						writeSel = 1'bx;
		endcase
	end

endmodule
