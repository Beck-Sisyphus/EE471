// EE 471 Lab 1,  Beck Pang, Spring 2015
// Main function for calling different counter onto the board
// @require: only call one counter a time
module DE1_SoC_RegisterFile (CLOCK_50, LEDR, SW, KEY);
	input 		 CLOCK_50;  // connect to system 50 MHz clock
	output[9:0] LEDR;
	input [9:0] SW;
	input [3:0] KEY;

	wire clk, clkControl;
	reg rst, button;
	reg [4:0] read0, read1, write;
	reg wrEn;
	wire [31:0] writeInput;
	wire [31:0] readOutput0, readOutput1;
	reg [9:0] count;
	//reg [31:0] newWrite;

	// clock divider with a button to control the speed
	reg [31:0] slowClock;		// system time base
	parameter speed = 25;
	always @(posedge CLOCK_50) 
		slowClock <= slowClock + 1'b1;

	assign clkControl = SW[0];
	// assign clk = clkControl ? slowClock[speed] : CLOCK_50;
	assign clk = slowClock[speed];

	assign rst = KEY[1];
	assign button = KEY[0];

	registerFile register(clk, read0, read1, write, wrEn, writeInput, readOutput0, readOutput1);	

	// We start the time line with a counter
	// For the first part, we write the data to address
	// Then we run a loop to read the output
	always @(posedge clk) begin
		if (!rst) begin
			count <= 'b0;
			wrEn  <= 1'b1; // Turn the write off
		end
		else if (count < 'd16) begin
			count <= count + 1'b1;
			wrEn  <= 1'b0; 
			write <= count;
			writeInput <= 32'hFFFF000F - count;
		end
		else if (count < 'd32) begin
			count <= count + 1'b1;
			wrEn  <= 1'b0;
			write <= count;
			writeInput <= 32'h0000FFF0 + count - 'h10;
		end
		// Read section
		else begin
			count <= count;
			wrEn  <= 1'b1;
			read0 <= 5'b00001;
			read1 <= 5'b10001;
		end
		// else if (count < 'd48) begin
		// 	count <= count + 1'b1;
		// 	wrEn  <= 1'b1;
		// 	read0 <= count - 'd32;
		// 	read1 <= count - 'd16;
		// end
		// else begin
		// 	count <= 'd32;
		// 	wrEn  <= 1'b1;
		// 	read0 <= 5'b0;
		// 	read1 <= 5'b10000;
		// end
	end
	
	// Finally, wire the LEDR with the last eight bit of output
	// if button is a logical 1, wire LEDR with readOutput1
	// else, wire LEDR with readOutput2
	// The bottom released is true
	assign LEDR[7:0] = button ? readOutput1[7:0] : readOutput0[7:0];
	// assign writeInput = wrEn ? 16'bZ : newWrite;

	// reg [1:0] ps, ns;
	
	// // States encoding: A, write first 16 bit
	// parameter [1:0] A = 2'b00, B = 2'b01, C = 2'b10, D = 2'b11;
	
	// // Next state logic
	// always @(*)
	// 	case (ps)
	// 		A: if (w) 	ns = B;
	// 			else		ns = A;
	// 		B: if (w)	ns = C;
	// 			else 		ns = A;
	// 		C: if (w)	ns = C;
	// 			else		ns = A;
	// 		default: 	ns = 2'bxx;
	// 	endcase
		
	// // Output logic
	// assign out = (ps == C);
	
	// // D Flip-flops
	// always @(posedge clk)
	// 	if (reset)
	// 		ps <= A;
	// 	else 
	// 		ps <= ns;

endmodule