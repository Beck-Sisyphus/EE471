
//  Build a test bench to test the design

module testBench;

	wire [12:0] 	pc;			 				//	connect the pc
	wire			clock;			 			//	connect the clock
	hal1 			aComputer (clock, pc);	 	//	build an instance of the computer
	test_it 		aTester(clock, pc);	 		//	build a tester
	
	initial
	begin
	  $dumpfile("hal1.vcd");
	  $dumpvars(1,aComputer);
	end

endmodule	

// The Computer - HAL1

module hal1 (clock, pc);

	//  declare the parameters
	input 			clock;
	output [12:0]	pc;

        reg [31:0]	m [7:0];	// 8 x 32 bit memory
        reg [12:0]	pc;			// 13 bit program counter
        reg [31:0]	acc;		// 32 bit accumulator
        reg [15:0]	ir;			// 16 bit instruction register
        reg [31:0]  r[7:0];		// 16 x 32 value 


	initial						//  initialize the pc and the accumulator
		begin					//  define the instruction rom
			pc = 0;
			acc = 0;
			$display("\nInitize acc with 0", acc);
			m[0] = 'h0000;		//	these are for illustration
			m[1] = 'h2001;
			m[2] = 'h4002;
			m[3] = 'h6003;
			m[4] = 'ha004;
			m[5] = 'hc005;
			m[6] = 'h6206;
			m[7] = 'h8007;
			
			r[0] = 'h0;		//	these are for illustration
			r[1] = 'h1;
			r[2] = 'h2;
			r[3] = 'h3;
			r[4] = 'h4;
			r[5] = 'h5;
			r[6] = 'h6;
			r[7] = 'h7;
		end
		
	always 
		begin
			@(posedge clock) 
			
			
			ir = m [pc];						// fetch an instruction
			
			if (ir[15:13] == 3'b000)			// begin decoding
				pc = m [ir [12:0]];				// and executing
			else if (ir[15:13] == 3'b001)
				pc = pc + m [ir [12:0]];
			else if (ir[15:13] == 3'b010)
				acc = m [ir [12:0]];
			else if (ir[15:13] == 3'b011)
				m [ir [12:0]] = acc;
			else if ((ir[15:13] == 3'b101) || (ir[15:13] == 3'b100))
				acc = acc - m [ir [12:0]];
			else if (ir[15:13] == 3'b110)
				begin
					acc = -m [ir [12:0]];
					pc = pc+1;
					acc = r[(ir[12:10])]+r[(ir[3:0])];
				end
			pc = (pc + 1)%8;					//increment program
												// counter
		end
endmodule


//  Test module

module test_it(clock, pc);


	//  declare the parameters
	input	[12:0]	pc;
	output          clock;	
	reg 			clock; 	// system clock
	
	parameter period = 1;
	
	initial
		clock = 0;
//	manage the clock
always
 	begin    
    	#(period) clock = ~clock;
  	end

//	manage the display  	
always @(posedge clock)
  begin
   	$strobe ($time,, "pc = %d", pc);	//	record every time tick
  	
  	//	look for changes
   	$monitor ($time,, "pc = %d", pc);	//  record only changes

	
    #(30*period);			// 	let clock cycle a couple of times

    #(period);				// 	needed to see END of a simulation

    $finish;				//	return to dos
  end
endmodule
