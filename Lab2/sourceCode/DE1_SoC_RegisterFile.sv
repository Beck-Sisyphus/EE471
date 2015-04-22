// EE 471 Lab 1,  Beck Pang, Spring 2015
// Main function for calling different counter onto the board
// @require: only call one counter a time
module DE1_SoC_RegisterFile (CLOCK_50, LEDR, SW, KEY, count, read0, read1, write, readOutput0, readOutput1, writeInput);
	input 		 CLOCK_50;  // connect to system 50 MHz clock
	output reg [9:0] LEDR;
	input [9:0] SW;
	input [3:0] KEY;

	wire clk, clkControl;
	reg rst, button, buttonSec;
	output reg [4:0] read0, read1, write;
	reg wrEn;
	output reg [31:0] writeInput;
//	wire [31:0] readOutput0, readOutput1;
	output [31:0] readOutput0, readOutput1;
	output reg [5:0] count;
	//reg [31:0] newWrite;

	// clock divider with a button to control the speed
	reg [31:0] slowClock;		// system time base
	parameter speed = 25;
	always @(posedge CLOCK_50) 
		slowClock <= slowClock + 1'b1;

	assign clkControl = SW[0];
	// assign clk = clkControl ? slowClock[speed] : CLOCK_50;
	assign clk = CLOCK_50;

	assign rst = KEY[2];
	assign buttonSec = KEY[1];
	assign button = KEY[0];

	registerFile register(clk, read0, read1, write, wrEn, writeInput, readOutput0, readOutput1);	

	// We start the time line with a counter
	// For the first part, we write the data to address
	// Then we run a loop to read the output
	
	// // Finally, wire the LEDR with the last eight bit of output
	// // if button is a logical 1, wire LEDR with readOutput1
	// // else, wire LEDR with readOutput2
	// // The bottom released is true
	// assign LEDR[7:0] = button ? readOutput1[7:0] : readOutput0[7:0];
	// assign writeInput = wrEn ? 16'bZ : newWrite;

	reg [1:0] ps, ns;
	
	// States encoding: A, write first 16 bit
	parameter [1:0] A = 2'b00, B = 2'b01, C = 2'b10, D = 2'b11;
	
	// Next state logic
	always @(*)
		case (ps)
			A: begin
				wrEn  = 1'b0;
				write = count;
				writeInput = 32'hFFFF000F - count;
				read0 = 'b0;
				read1 = 'b0;
				LEDR[7:0] = 8'b10101010;
			if (count == 'd15) 	ns = B;
				else		ns = A;
			end
			B: begin
				wrEn  = 1'b0;
				write = count;
				writeInput = 32'h0000FFF0 + count - 'h10;
				read0 = 'b0;
				read1 = 'b0;
				LEDR[7:0] = 8'b01010101;
			if (count == 'd31)	ns = C;
				else if (count < 'd16) ns = A;
				else 		ns = B;
			end
			C: begin
				wrEn  = 1'b1;
				write = 'bZ;
				writeInput = 32'hZ;
				read0 = count - 'd32;
				read1 = (count - 'd16) & (5'b01111);
				// LEDR[7:0]  = readOutput0[7:0];
				LEDR[7:0] = 8'b00100100;
			if (button == 1'b1)	ns = C;
				else		ns = D;
			end
			D: begin
				wrEn  = 1'b1;
				write = 'bZ;
				writeInput = 32'hZ;
				read0 = count - 'd32;
				read1 = (count - 'd16) & (5'b01111);
				// LEDR[7:0]  = readOutput1[7:0];
				LEDR[7:0] = 8'b10000001;
			if (button == 1'b0)	ns = D;
				else 		ns = C;
			end
			default: 	ns = 2'bxx;
		endcase
		
	// D Flip-flops
	always @(posedge clk)
		if (!rst) begin
			ps <= A;
			count <= 6'b0;
		end
		else begin
			ps <= ns;
			count <= count + 1'b1;
		end

endmodule

module DE1_SoC_RegisterFile_testbench();
	wire     [9:0] LEDR;
	wire     [5:0] count;
	wire 	 [4:0] read0, read1, write;
	wire 	 [31:0] readOutput0, readOutput1;
	wire	 [31:0] writeInput;
	reg      [3:0] KEY;
	reg      [9:0] SW;
	reg      CLOCK_50;
	
	DE1_SoC_RegisterFile dut (.CLOCK_50, .LEDR, .SW, .KEY, .count, .read0, .read1, .write, .readOutput0, .readOutput1, .writeInput);
	
	// Set up the clock
	parameter CLOCK_PERIOD = 100;
	initial CLOCK_50 = 1;
	always begin
		#(CLOCK_PERIOD / 2);
		CLOCK_50 = ~CLOCK_50;
	end 
	
	// Set up the inputs to the design. Each line is a clock cycle.
	initial begin		
											@(posedge CLOCK_50);
			KEY[2] <= 1'b0; 				@(posedge CLOCK_50);
			KEY[2] <= 1'b1; 				@(posedge CLOCK_50);
			KEY[1] <= 1'b0; 				@(posedge CLOCK_50);
			KEY[1] <= 1'b1; 				@(posedge CLOCK_50);
			KEY[0] <= 1'b0; 				@(posedge CLOCK_50);
			KEY[0] <= 1'b1; 				@(posedge CLOCK_50);
											@(posedge CLOCK_50);
											@(posedge CLOCK_50);
											@(posedge CLOCK_50);
											@(posedge CLOCK_50);
											@(posedge CLOCK_50);
											@(posedge CLOCK_50);
											@(posedge CLOCK_50);
											@(posedge CLOCK_50);
											@(posedge CLOCK_50);
											@(posedge CLOCK_50);
											@(posedge CLOCK_50);
											@(posedge CLOCK_50);
											@(posedge CLOCK_50);
											@(posedge CLOCK_50);
											@(posedge CLOCK_50);
											@(posedge CLOCK_50);
											@(posedge CLOCK_50);
											@(posedge CLOCK_50);
											@(posedge CLOCK_50);
											@(posedge CLOCK_50);
											@(posedge CLOCK_50);
											@(posedge CLOCK_50);
											@(posedge CLOCK_50);
											@(posedge CLOCK_50);
											@(posedge CLOCK_50);
											@(posedge CLOCK_50);
											@(posedge CLOCK_50);
											@(posedge CLOCK_50);
											@(posedge CLOCK_50);
											@(posedge CLOCK_50);
											@(posedge CLOCK_50);
											@(posedge CLOCK_50);
											@(posedge CLOCK_50);
											@(posedge CLOCK_50);
											@(posedge CLOCK_50);
											@(posedge CLOCK_50);
											@(posedge CLOCK_50);
											@(posedge CLOCK_50);
											@(posedge CLOCK_50);
											@(posedge CLOCK_50);
											@(posedge CLOCK_50);
											@(posedge CLOCK_50);
											@(posedge CLOCK_50);
											@(posedge CLOCK_50);
											@(posedge CLOCK_50);
											@(posedge CLOCK_50);
											@(posedge CLOCK_50);
											@(posedge CLOCK_50);
											@(posedge CLOCK_50);
											@(posedge CLOCK_50);
											@(posedge CLOCK_50);
											@(posedge CLOCK_50);
											@(posedge CLOCK_50);
											@(posedge CLOCK_50);
											@(posedge CLOCK_50);
											@(posedge CLOCK_50);
											@(posedge CLOCK_50);
											@(posedge CLOCK_50);
											@(posedge CLOCK_50);
											@(posedge CLOCK_50);
											@(posedge CLOCK_50);
											@(posedge CLOCK_50);
											@(posedge CLOCK_50);
											@(posedge CLOCK_50);
											@(posedge CLOCK_50);
											@(posedge CLOCK_50);
											@(posedge CLOCK_50);
											@(posedge CLOCK_50);
											@(posedge CLOCK_50);
											@(posedge CLOCK_50);
											@(posedge CLOCK_50);
											@(posedge CLOCK_50);
											@(posedge CLOCK_50);
											@(posedge CLOCK_50);
											@(posedge CLOCK_50);
											@(posedge CLOCK_50);
											@(posedge CLOCK_50);
											@(posedge CLOCK_50);
											@(posedge CLOCK_50);
											@(posedge CLOCK_50);
											@(posedge CLOCK_50);
											@(posedge CLOCK_50);
											@(posedge CLOCK_50);
											@(posedge CLOCK_50);
											@(posedge CLOCK_50);
											@(posedge CLOCK_50);
											@(posedge CLOCK_50);
											@(posedge CLOCK_50);
											@(posedge CLOCK_50);
											@(posedge CLOCK_50);
		$stop;
	end
endmodule