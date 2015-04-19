//  model a module that uses a bidirectional i/o port

module IOModule(dataBus, in, sel, reset, clock);

  inout [1:0]   dataBus;
  input         in;
  input 		sel;
  input         reset;
  input         clock;

  reg [1:0]     myData;	      	// register to store myData
 
	//  in <-0 we have output
	//  in <-1 we have input
  assign dataBus = !in ? myData : 2'bz;

  always@ (posedge reset or posedge clock)
  
  begin

	if(reset)
	begin
		//  reset myData - initialize
        myData = 2'b00;
	end  
	
	//  manage in and out 
	//  in <-0 we have output
	//  in <-1 we have input
	else
        begin
		//  start with out		
          if (!in)
		  begin
		  //  model outputing data to data bus
		  //  choose the data
			if (sel)
				begin
					myData = 2'b01;
				end
			else
				begin
					myData = 2'b10;
				end
		  end
		  
		  else if(in)
		  begin
			myData = dataBus;
		  end

        end

  end
endmodule