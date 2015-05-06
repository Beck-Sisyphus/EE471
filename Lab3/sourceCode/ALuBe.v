module ALuBe (clk,oper, A, B, dataOut,Z,V,C,N); 
	input clk;
	input [2:0] oper;
	input [31:0] A, B;
	output Z, V, C, N;
	output reg [31:0] dataOut;
	
	always@(*)  begin
		case (oper) 
			0: begin
				dataOut = 0;
				end 
			1: begin
				dataOut = A + B;
				end 
			2: begin
				dataOut = A - B;
				end 
			3: begin
				dataOut = A & B;
				end 
			4: begin
				dataOut = A | B;
				end 
			5: begin
				dataOut = A ^ B;
				end
			6: begin
				dataOut = A < B;
				end
			7: begin
				dataOut = A << B[2:0];
				end
		endcase
	end
	
	assign Z = dataOut == 0;
	assign V = ~(A[31] ^ B[31]) & (A[31] ^ dataOut[31]);
	assign C = (dataOut  == 0) | (dataOut == 32'hFFFFFFFF);
	assign N = dataOut[31];

endmodule
