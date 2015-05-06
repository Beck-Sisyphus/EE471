// EE 471 Lab 3,  Beck Pang, Spring 2015
// combine SRAM and ALU together
// @require:
// Instruction formula is formed by 3 bit control, 5 bit for address of A
// 5 bit for address of B
// fetch instructions and data into SRAM, and then move to register file
module DE1_SoCPhaseII (CLOCK_50, LEDR, SW, KEY);
	input CLOCK_50;  // connect to system 50 MHz clock
	output reg [9:0] LEDR;
	input [9:0] SW;
	input [3:0] KEY;
	
	reg  [2:0] ps, ns;
	wire [15:0] data;
	reg  [6:0] count; // 0~127
	reg  WrEn, regWR;
	reg  [10:0] adx;
	reg  [15:0] store;
	wire clkControl, rst, slowClk, fetchStart;
	reg  [4:0] readAdx0, readAdx1, writeAdx;
	reg  [31:0] writeData;
	wire [31:0] readOutput0, readOutput1;
	wire [2:0]  opcode;
	wire [4:0]  regAdx0, regAdx1;

	assign clkControl = SW[8];
	assign fetchStart = SW[6];   // fetch starts when SW[6] turns on
	assign rst = SW[9];
	assign data = WrEn ? 16'bZ : store; // control the tri-state 
	SRAM2Kby16 memory(CLOCK_50, adx,  WrEn, data);
	registerFile regs(CLOCK_50, readAdx0, readAdx1, writeAdx, regWR, writeData, readOutput0, readOutput1);
	ALUnit logic(CLOCK_50, control, busA, busB, busOut, zero, overflow, carryout, negative);
	InstrucDecoder getInstruc(data, opcode, regAdx0, regAdx1);

	parameter loadData = 3'b000, loadInstr = 3'b001, transfer = 3'b010, 
				fetch = 3'b011, decode = 3'b100, execute = 3'b101, writeBack = 3'b110, nul = 3'bx;

	always @(*)
		case (ps)
			loadData : begin // write data into SRAM. Active low Write Enable
				WrEn  = 0;
				regWR = 1;
				adx   = count + 8'h80;
				store = 7'b1111111 - count;
				if (count == 7'b1111111) 
					ns = loadInstr;
				else
					ns = loadData;
			end
			loadInstr: begin // create instruction and data address using counter
				WrEn  = 0;
				regWR = 1;
				adx   = count;
				// count[2:0] is opcode, {1'b0, count[3:0]} the address of A, {1'b1, count[3:0]} the address of B
				store = {count[2:0], {1'b0, count[3:0]}, {1'b1, count[3:0]}, 3'b0}; 
				if (count[4:0] == 5'b11111) 
					ns = transfer;
				else 
					ns = loadInstr;
			end
			transfer : begin // write data into register file
				WrEn  = 1;
				regWR = 0;
				adx   = count + 8'h80;
				writeAdx = count[4:0];
				writeData= data;
				if (fetchStart) 
					ns = fetch;
				else
					ns = transfer;
			end
			fetch    : begin // read from register file to ALU
				WrEn  = 1;
				regWR = 1;
				adx   = count;
				ns    = decode;
			end
			decode   : begin
				WrEn  = 1;
				regWR = 1;
				adx   = adx;
				readAdx0 = regAdx0;
				readAdx1 = regAdx1;
				ns    = execute;
			end
			execute  : begin
				WrEn  = 1;
				regWR = 1;
				adx   = adx;
				readAdx0 = regAdx0;
				readAdx1 = regAdx1;
				control = opcode;
				busA  = readOutput0;
				busB  = readOutput1;
				ns    = writeBack;
			end
			writeBack: begin
				WrEn  = 1;
				regWR = 0;
				writeAdx = regAdx0;
				writeData= busOut;
				ns    = fetch;
			end
			default  : begin
				WrEn  = 1'bx;
				regWR = 1'bx;
				ns = nul;
			end
		endcase


	always @(posedge CLOCK_50) begin
		if (rst) begin
			ps   <= loadData;
			count <= 7'b0;
		end
		else begin
			ps 	 <= ns;
			count <= count + 1'b1;
		end
	end

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