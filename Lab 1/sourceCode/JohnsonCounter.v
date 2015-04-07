// Beck Pang
// University of Washington, Seattle
// Apr. 6th, 2015
// EE 471, Lab 1

module JohnsonCounter(clk,rst_n, out);
	input clk, rst_n;
	output reg [3:0] out;
	reg [3:0] outns;


	always @(*)
	begin
		outns[3] = ~out[0];
		outns[2:0] = out[3:1];
	end

// DFFs
    always @(negedge rst_n or posedge clk)
    	if (!rst_n)
            out <= 4'b0;
        else 
        	out <= outns;
endmodule

module testBench ();

	// connext the two modules
	wire clk, rst_n;
	wire [3:0] out;

	// declare an instance of the AND module
	JohnsonCounter myCounter (clk, rst_n, out);

	// Running the GUI part of simulation
	Tester aTester (clk, rst_n, out);

	// file for gtkwave

	initial
	begin
		$dumpfile("JohnsonCounter.vcd");
		$dumpvars(1, myCounter);
	end

endmodule

module Tester (
	output reg clk, rst_n,
	input [3:0] out
);

	parameter stimDelay = 20;

	// generate a clock
	always #(stimDelay/2) clk = ~clk;

	initial // Response
	begin
		$display("\t\t clk rst_n \t out \t   Time ");
		$monitor("\t %b ", out, $time);
		clk = 'b0;
	end

	always @(posedge clk) // Stimulus
	begin
					rst_n = 'b0;
		#stimDelay	rst_n = 'b1; 
		#(32*stimDelay)  rst_n = 'b0;
		#stimDelay  clk = 'b1;
		#(32*stimDelay)  clk = 'b0;
		#stimDelay  clk = 'b1;
		#(2*stimDelay);
		$stop;
		$finish;
	end

endmodule