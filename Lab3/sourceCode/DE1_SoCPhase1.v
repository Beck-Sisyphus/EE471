// EE 471 Lab 1,  Beck Pang, Spring 2015
// Main function for calling different counter onto the board
// @require: only call one counter a time


`include "hexOnHex.v"

`include "Implementation/mux2_1.sv"
`include "Implementation/mux4_1.sv"
`include "Implementation/mux8_1.sv"
`include "Implementation/mux32_1.sv"
`include "Implementation/DFlipFlop.sv"
`include "Implementation/registerSingle.sv"
`include "Implementation/register.sv"
`include "Implementation/decoder5_32.sv"
//`include "DE1_SoCPhase1.v"

`include "adder_subtractor.v"
`include "flag.v"
`include "adder16b.v"
`include "adder4b.v"
`include "fullAdder1b.v"
`include "lookAhead4b.v"
`include "addition.v"
`include "subtract.v"
`include "andGate.v"
`include "orGate.v"
`include "xorGate.v"
`include "setLT.v"
`include "shiftll.v"
`include "ALUnit.sv"
`include "SRAM2Kby16.v"
`include "registerFile.sv"
module DE1_SoCPhase1 (CLOCK_50, LEDR, HEX0, HEX1, HEX2, HEX3, SW, KEY);
	input CLOCK_50;  // connect to system 50 MHz clock
	output [9:0] LEDR;
	output [6:0] HEX0, HEX1, HEX2, HEX3;
	input [9:0] SW;
	input [3:0] KEY;
	
	reg [31:0] AL, BL, A, B, data;
	reg [1:0] count;
	reg enter, eHold;

	wire clk, run, res, Z, V, C, N;
	wire [31:0]	dataOut;
	wire [3:0]digits;
	reg [2:0] oper;
	reg [1:0] sel;

	initial begin 
	oper = 0;
	sel = 0;
	enter = 0;
	eHold = 0;
	count = 0;
	AL = 0;
	BL = 0;
	A = 0;
	B = 0;
	data = 0;
	end

	
	assign LEDR[3] = Z;
	assign LEDR[2] = V;
	assign LEDR[1] = C;
	assign LEDR[0] = N;
	
	assign clk = CLOCK_50;
	//Interpreted by the system as an Enter. When Enter is pressed
	// the ALU will read the state of the input switches and respond accordingly
	//assign enter = ~KEY[0];
	//Directs the ALU to perform the specified operation and display the results.
	assign run = ~KEY[1];
	// sets the hex digits 
	assign digits = SW[3:0];


	// Specify whether operand A or B is to be entered or the result is to be displayed


	// controls the hex
	hexOnHex hex0(data[3:0], HEX0);
	hexOnHex hex1(data[7:4], HEX1);
	hexOnHex hex2(data[11:8], HEX2);
	hexOnHex hex3(data[15:12], HEX3);
	
	ALUnit alzheimers (clk,oper, A, B, dataOut,Z,V,C,N); 
	//ALuBe alzheimers (clk,oper, A, B, dataOut,Z,V,C,N); 
	
	always @(posedge clk) begin
		// hex display done
		case(sel)
				0: data <= AL;
				1: data <= BL;
				default: data <= dataOut;
		endcase
		
		if(~KEY[0]) begin
			if(eHold) begin 
				enter <= 0;
				//eHold <=0;
			end else  begin 
				enter <= 1;
				//eHold <= 1;
			end
			eHold <= 1;
		end	
		else begin 
			eHold <= 0;
			enter <= 0;
		end 
		

		if(enter) begin
			if(sel != SW[9:8]) begin 
				sel <= SW[9:8];
				count <= 0;
			end else begin
				if(sel == 0)	
					case(count)
						0: AL[3:0] = digits;
						1: AL[7:4] = digits;
						2: AL[11:8] = digits;
						3: AL[15:12] = digits; 
					endcase
				else if(sel == 1)	
					case(count)
						0: BL[3:0] = digits;
						1: BL[7:4] = digits;
						2: BL[11:8] = digits;
						3: BL[15:12] = digits; 
					endcase
				count = count + 1;
			end
		end
		
		if(run) begin
			oper <= SW[6:4];
			A <= AL;
			B <= BL;
		end	
	end

endmodule 		

module interfaceTest();
	wire clk;  // connect to system 50 MHz clock
	wire [9:0] LEDR;
	wire [9:0] SW;
	wire [3:0] KEY;
	wire [6:0] HEX0;
	wire [6:0] HEX1;
	wire [6:0] HEX2;
	wire [6:0] HEX3;	
	
	DE1_SoCPhase1 dut (clk, LEDR, HEX0, HEX1, HEX2, HEX3, SW, KEY);
	phase1Tester test (clk, SW, KEY);
	
	initial begin
		$dumpfile("Phase1Test.vcd");
		$dumpvars(1, dut);
	end 
endmodule 


module phase1Tester(clk,  SW, KEY);
	output reg clk;
	output reg [9:0] SW;
	output reg [3:0] KEY;
	
	reg [2:0] control;
	initial begin 
	control = 0;
	SW = 0;
	KEY = 15;
	end

	//controls = SW[6:4];
	//inVal = SW[3:0];
	//sel = SW[9:8];
	//enter = ~KEY[0];
	//run = ~KEY[1];
	
	parameter [2:0] NOP = 3'b000, ADD= 3'b001, SUB = 3'b010, AND = 3'b011, OR = 3'b100, XOR = 3'b101, SLT = 3'b110, SLL = 3'b111;
	parameter d = 20;
 
	// Set up the clocking
	always #(d/2) clk= ~clk;
	
	initial begin
		$display("clk \t SW \t KEY ");
		#d
		clk =0;
	end
	
	// Set up the inputs to the design
	initial begin
		$monitor("%b \t %b \t %b \t %b", clk,SW, KEY, $time);
		/*//#(d*3); //SW[9:8] = 0; //KEY[0] =0;
		//#d; //KEY[0]= 1;
		//#d;

		#d; SW[9:8] = 1; SW[3:0] =2;#d; #d; #d; KEY[0] = 0;//set value of B
		#d;#d; KEY[0] = 1;
		#d;
		
		#d; SW[9:8] = 0; SW[3:0] = 1;#d;#d; KEY[0]= 0; //set value of A
		#d#d; KEY[0] = 1;
		#d;
		
//		#d; SW[3:0] = 2; KEY[0] = 0;
//		#d; KEY[0] = 1;
//		#d;
		#d; SW[9:8] = 3; KEY[0] = 0;
		#d#d; KEY[0] = 1; // display result
		#d;*/
		#d SW[3:0] = 1;	KEY[0] = 0; #d KEY[0] = 1;
		#d SW[8]   = 1;	KEY[0] = 0; #d KEY[0] = 1;
		#d SW[3:0] = 2;	KEY[0] = 0; #d KEY[0] = 1;
		#d SW[9]   = 1;	KEY[0] = 0; #d KEY[0] = 1;
		// operation tests
		#d; SW[6:4] = NOP; KEY[1] = 0;
		#d; SW[6:4] = ADD;
		#d; SW[6:4] = SUB; 
		#d; SW[6:4] = AND;
		#d; SW[6:4] = OR;
		#d; SW[6:4] = XOR;
		#d; SW[6:4] = SLT;
		#d; SW[6:4] = SLL;
	
		
		#(d*3);
		
		$stop;
		$finish;
	end
endmodule 

