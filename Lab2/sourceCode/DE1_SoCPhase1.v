// EE 471 Lab 1,  Beck Pang, Spring 2015
// Main function for calling different counter onto the board
// @require: only call one counter a time
module DE1_SoC (CLOCK_50, LEDR, HEX0, HEX1, HEX2, HEX3, SW, KEY);
	input CLOCK_50;  // connect to system 50 MHz clock
	output reg [9:0] LEDR;
	output [6:0] HEX0, HEX1, HEX2, HEX3;
	input [9:0] SW;
	input [3:0] KEY;
	
	reg [31:0] A, B, data;
	reg [1:0] count, currMode;

	wire clk, enter, run, res, Z, V, C, N;
	wire [2:0] oper;
	wire [1:0] sel;
	
	assign clk = CLOCK_50;
	//Interpreted by the system as an Enter. When Enter is pressed
	// the ALU will read the state of the input switches and respond accordingly
	assign enter = ~KEY[0];
	//Directs the ALU to perform the specified operation and display the results.
	assign run = ~KEY[1];
	// sets the hex digits 
	assign digits = SW[3:0];
	// Operation code 
	assign oper = SW[6:4];
	// Specify whether operand A or B is to be entered or the result is to be displayed
	assign sel = SW[9:8];
	
	// controls the hex
	hexOnHex hex0(data[3:0], HEX0);
	hexOnHex hex1(data[7:4], HEX1);
	hexOnHex hex2(data[11:8], HEX2);
	hexOnHex hex3(data[15:12], HEX3);
	
	
	always @(posedge clk) begin
		if(enter) begin
			case(sel)
				0: begin
					data = A;
					currMode =
					end
				1: begin 
					data = B;
					end
				2: begin

					end
				3: begin

					end
				default:
			endcase
			
			case(oper)
				0: //NOP
				1: //ADD
				2: //SUB
				3: //AND
				4: //OR
				5: //XOR
				6: //SLT
				7: //SLL
				default:
			endcase
			
			case(digits)
			endcase
		end 	
		else if (run) begin
				0: begin
					data = A;
					end
				1: begin 
					data = B;
					end
				2: begin

					end
				3: begin

					end
				default:
			endcase
			
			case(oper)
				0: //NOP
				1: //ADD
				2: //SUB
				3: //AND
				4: //OR
				5: //XOR
				6: //SLT
				7: //SLL
				default:
			endcase
			
			case(digits)
			endcase
		end 	

endmodule 		
			/*
	wire clk;
	wire [15:0] data;
	reg [6:0] hold;
	reg WrEn, regWR;
	reg [10:0] adx;
	reg [15:0] store;
	wire [1:0] state, blockSel;
	wire clkControl, rst, slowClk, outSel;
	reg [4:0] readAdd0, readAdd1, writeAdd;
	reg [31:0] writeData;
	wire [31:0] readOutput0, readOutput1;
	//reg [15:0] data;
	//assign data[6:0] = SW[6:0]
	assign clkControl = SW[8];
	assign state = SW[7:6];
	assign blockSel = SW[5:4];
	assign outSel = SW[3];
	assign rst = SW[9];
	assign data = WrEn ? 16'bZ : store;
	SRAM2Kby16 memory(clk, adx,  WrEn, data);
	clkSlower counter(slowClk, CLOCK_50, rst);
	registerFile regs(clk, readAdd0, readAdd1, writeAdd, regWR, writeData, readOutput0, readOutput1);
	
	always @(posedge clk) begin
		if(rst) begin
			hold = 0;
			adx = 0;
			WrEn = 1;
			LEDR = 0;
		end else if(state == 0) begin
			WrEn = 0;
			adx = hold;
			store = 7'b1111111 - hold;
			LEDR[6:0] = hold;
		end else if(state == 1) begin
			WrEn = 1;
			regWR = 1;
			writeAdd = hold[4:0];
			adx = blockSel * 32 + hold[4:0]; 
			writeData[15:0] = data;
		end else if(state == 2) begin
			WrEn = 1;
			regWR = 0;
			readAdd0 = hold[3:0];
			readAdd1 = 16 + hold[3:0];
			LEDR = outSel ? readOutput0[9:0] : readOutput1[9:0];
		end else if(state == 3) begin
			WrEn = 0;
			regWR = 0;
			if(blockSel[0]) begin
				readAdd1 = hold[5:2] + 16;
				if(hold[0]) begin 
					store = readOutput1[15:0];
					adx = 179 + hold[5:2];
				end else begin 
					store = readOutput1[15:0];
					adx = 145 + hold[5:2];
				end
			end else begin
				readAdd0 = hold[5:2];
				if(hold[0]) begin 
					store = readOutput0[15:0];
					adx = 162 + hold[5:2];
				end else begin 
					store = readOutput0[15:0];
					adx = 128 + hold[5:2];
				end
			end
		end
		hold = hold + 1'b1;
	end
	

	assign clk = clkControl ? slowClk : CLOCK_50;
	
endmodule 

module SendP2SBufferTestbench();
	reg CLOCK_50;  // connect to system 50 MHz clock
	wire [9:0] LEDR;
	reg [9:0] SW;
	reg [3:0] KEY;
	DE1_SoC dut (CLOCK_50, LEDR, SW, KEY);
	// Set up the clocking
	
	parameter d = 20;
	initial begin
		CLOCK_50 = 1;
		SW = 12;
		KEY = 0;
	end
	
	always #(d/2) CLOCK_50 = ~CLOCK_50;
	

	// Set up the inputs to the design
	initial begin
		#(d*10); SW[9] = 1;
		#d; SW[9] = 0; SW[8] = 1;
		#(d*500); SW[8] = 0;
		#d SW[5:0] = 64;
		#d SW[5:0] = 32;
		#d SW[5:0] = 16;
		#d SW[5:0] = 8;
		#d SW[5:0] = 120;
		$stop;
	end
endmodule 
*/
