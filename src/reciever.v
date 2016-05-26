`timescale 1ns / 1ns


module receiver(
    input data_in,																	// 1 bit data received from Rx bus
    input rx_clk,																		// clk
	 input reset,
	 output signal,																	// when signal == 1, signifies that one byte of data is received
    output [7:0] data_out															// output of the received data
    );

	reg [7:0] data;																	// Store the received data
	reg [7:0] shift;																	// Shift register to receive the 8 bit data
	reg [3:0] state;
	reg sig;																				// sig set when received a data

	assign data_out = data;
	assign signal = sig;


always @(posedge rx_clk , posedge reset)
	begin
	if (reset) 																			// clear registers
		begin
		data <= 0;
		state <= 0;
		shift <= 0;
		sig = 0;							
		end 
	else if (state == 0 && data_in == 1)
		state <= 0;																		// stay in state 0 if line is idle (high)
	else if (state == 0 && data_in == 0)
		state <= 1;																		// go to state 1 when line goes low
	else if (state == 9) 															
		begin																				// assign data to output port and raise flag when 8 bits have been read
	   state <= 10;
		data <= shift;
		sig = 1;									
		end
	else if (state == 10)
		begin																				// one clock cycle delay, clear flag bit. 
	   state <= 11;
		sig = 0;														
		end
	else if (state == 11)
		begin
	   state <= 0;																		// return to state 0.
		sig = 0;															
		end
	else
		begin
	   state <= state+1'b1;																// increment state and shift in one bit of data
		shift[0] <= shift [1];
		shift[1] <= shift [2];
		shift[2] <= shift [3];
		shift[3] <= shift [4];
		shift[4] <= shift [5];
		shift[5] <= shift [6];
		shift[6] <= shift [7];
		shift[7] <= data_in;
		end
	end	
	
	

endmodule
