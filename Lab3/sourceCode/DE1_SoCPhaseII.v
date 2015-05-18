// EE 471 Lab 3,  Beck Pang, Spring 2015
// combine SRAM and ALU together
// @require:
// Instruction formula is formed by 3 bit control, 5 bit for address of A
// 5 bit for address of B
// fetch instructions and data into SRAM, and then move to register file
module DE1_SoCPhaseII (CLOCK_50, LEDR, SW, KEY);
	input CLOCK_50;  // connect to system 50 MHz clock
	output [9:0] LEDR;
	input [9:0] SW;
	input [3:0] KEY;
	
	reg  [2:0] ps, ns;
	wire [15:0] data;
	reg  [7:0] count; // 0~255
	reg  WrEn, regWR;
	reg  [10:0] adx;
	reg  [15:0] store;
	reg  [2:0] control;
	wire rst, fetchStart;
	reg  [4:0] readAdx0, readAdx1, writeAdx;
	reg  [31:0] writeData;
	wire [31:0] readOutput0, readOutput1;
	
	wire [2:0]  opcode;
	wire [4:0]  regAdx0, regAdx1;
	
	reg  [31:0] busA, busB;
	wire [31:0] busOut;
	wire zero, overflow, carryout, negative;
	
	assign fetchStart = SW[6];   // fetch starts when SW[6] turns on
	assign rst = SW[9];
	assign data = WrEn ? 16'bZ : store; // control the tri-state 
	assign LEDR[3:0] = {zero, overflow, carryout, negative};
	SRAM2Kby16 memory(CLOCK_50, adx,  WrEn, data);
	registerFile regs(CLOCK_50, readAdx0, readAdx1, writeAdx, regWR, writeData, readOutput0, readOutput1);
	ALUnit logicUnit(CLOCK_50, control, busA, busB, busOut, zero, overflow, carryout, negative);
	InstrucDecoder getInstruc(data, opcode, regAdx0, regAdx1);

	parameter loadData = 3'b000, loadInstr = 3'b001, transfer = 3'b010, 
				fetch = 3'b011, decode = 3'b100, execute = 3'b101, writeBack = 3'b110, nul = 3'bx;

	always @(posedge CLOCK_50)
		case (SW[6:4])
			loadData : begin // write data into SRAM. Active low Write Enable
				WrEn  = 0;
				regWR = 1;
				writeAdx = 0;
				writeData = 0;
				readAdx0 = 0;
				readAdx1 = 16;
				control = 0;
				adx   = count[6:0] + 8'h80;
				store  = 7'b1111111 - count[6:0];
//				if (fetchStart)
//					ns = fetch;
//				else if (count[6:0] == 7'b1111111) 
//					ns = loadInstr;
//				else
//					ns = loadData;
			end
			loadInstr: begin // create instruction and data address using counter
				WrEn  = 0;
				regWR = 1;
				adx   = count[6:0];
				// count[6:4] is opcode, {1'b0, count[3:0]} the address of A, {1'b1, count[3:0]} the address of B,
				store = {count[6:4], {1'b0, count[3:0]}, {1'b1, count[3:0]}, 3'b0}; 
//				if (fetchStart)
//					ns = fetch;
//				else if (count[6:0] == 7'b1111111) 
//					ns = transfer;
//				else 
//					ns = loadInstr;
			end
			transfer : begin // write data into register file
				WrEn  = 1;
				regWR = 0;
				adx   = count[4:0] + 8'h80;
				readAdx0 = 0;
				readAdx1 = 16;
				control = 0;
				writeAdx = count[4:0];
				writeData= {{16{data[15]}}, data};
//				if (fetchStart) 
//					ns = fetch;
//				else
//					ns = transfer;
			end
			fetch    : begin // read from register file to ALU
				if(count[0]) begin
					WrEn  = 1;
					regWR = 1;
					adx   = count[7:1];
					readAdx0 = regAdx0;
					readAdx1 = regAdx1;
					control = opcode;
					busA  = readOutput0;
					busB  = readOutput1;
				//ns    = writeBack;
			//end
			/*decode   : begin
				WrEn  = 1;
				regWR = 1;
				adx   = adx;
				readAdx0 = regAdx0;
				readAdx1 = regAdx1;
				control = opcode;
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
			end*/
			//writeBack: begin
				end else begin
					WrEn  = 1;
					regWR = 0;
					writeAdx = regAdx0;
					writeData= busOut;
					//if (fetchStart) 
						//ns= fetch;
					//else
						//ns= execute;   
				end
//			execute:begin
//				WrEn = 1;
//				regWR = 0;
//				readAdx0 = count[4:0];
//				readAdx1 = 5'h10 + count[4:0];
//				adx = 8'h80 + count[3:0];
//				if(!fetchStart)
//					ns = loadData;
//				else
//					ns = execute;
			end
			default  : begin
				WrEn  = 1'bx;
				regWR = 1'bx;
				ns = nul;
			end
		endcase


	always @(posedge CLOCK_50) begin
		if (rst) begin
			//ps   <= loadData;
			count <= 8'b0;
		end
		else begin
			//ps 	 <= ns;
			count <= count + 1'b1;
		end
	end

endmodule 

// vlog "./sourceCode/DE1_SoCPhaseII.v"

// vlog "./sourceCode/Implementation/mux2_1.sv"
// vlog "./sourceCode/Implementation/mux4_1.sv"
// vlog "./sourceCode/Implementation/mux8_1.sv"
// vlog "./sourceCode/Implementation/mux32_1.sv"
// vlog "./sourceCode/Implementation/register.sv"
// vlog "./sourceCode/Implementation/registerSingle.sv"
// vlog "./sourceCode/Implementation/DFlipFlop.sv"
// vlog "./sourceCode/Implementation/counter.v"
// vlog "./sourceCode/Implementation/decoder5_32.sv"
// vlog "./sourceCode/Implementation/decoder8_256.sv"
// vlog "./sourceCode/Implementation/decoder11_2048.sv"

// vlog "./sourceCode/InstrucDecoder.v"
// vlog "./sourceCode/SRAM2Kby16.v"
// vlog "./sourceCode/registerFile.sv"
// vlog "./sourceCode/ALUnit.sv"
// vlog "./sourceCode/addition.v"
// vlog "./sourceCode/subtract.v"
// vlog "./sourceCode/andGate.v"
// vlog "./sourceCode/orGate.v"
// vlog "./sourceCode/xorGate.v"
// vlog "./sourceCode/setLT.v"
// vlog "./sourceCode/shiftll.v"
// vlog "./sourceCode/adder_subtractor.v"
// vlog "./sourceCode/flag.v"
// vlog "./sourceCode/adder16b.v"
// vlog "./sourceCode/adder4b.v"
// vlog "./sourceCode/fullAdder1b.v"
// vlog "./sourceCode/lookAhead4b.v"

module DE1_SoCPhaseII_Testbench();
	reg CLOCK_50;  // connect to system 50 MHz clock
	wire [9:0] LEDR;
	reg [9:0] SW;
	reg [3:0] KEY;

	DE1_SoCPhaseII dut (CLOCK_50, LEDR, SW, KEY);
	// Set up the clocking
	
	parameter CLOCK_PERIOD = 100;
	initial CLOCK_50 = 1;
	always begin
		#(CLOCK_PERIOD / 2);
		CLOCK_50 = ~CLOCK_50;
	end 
	

	// Set up the inputs to the design
	integer i;
	initial begin
						      	@(posedge CLOCK_50);
		SW[9] <= 1;		      	@(posedge CLOCK_50);
		SW[8:0]	<= 9'b0;		@(posedge CLOCK_50);
		SW[9] <= 0;		      	@(posedge CLOCK_50);
						      	@(posedge CLOCK_50);
		for (i = 0; i < 300; i = i + 1) begin
								@(posedge CLOCK_50);
		end
		SW[6] <= 1;				@(posedge CLOCK_50);
		for (i = 0; i < 19; i = i + 1) begin
								@(posedge CLOCK_50);
		end
		SW[6] <= 0;				@(posedge CLOCK_50);
		SW[6] <= 1;				@(posedge CLOCK_50);
		for (i = 0; i < 18; i = i + 1) begin
								@(posedge CLOCK_50);
		end
		SW[6] <= 0;				@(posedge CLOCK_50);
		SW[6] <= 1;				@(posedge CLOCK_50);
		for (i = 0; i < 17; i = i + 1) begin
								@(posedge CLOCK_50);
		end
		SW[6] <= 0;				@(posedge CLOCK_50);
		SW[6] <= 1;				@(posedge CLOCK_50);
		for (i = 0; i < 16; i = i + 1) begin
								@(posedge CLOCK_50);
		end
		$stop;
	end
endmodule 