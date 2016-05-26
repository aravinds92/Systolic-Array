`timescale 1ns / 1ns

module transmitter(
	input [7:0] data_in,															// one byte of data you want to send out
	input tx_clk,																	// clk
	input reset,
	input start,																	// Only start to send out data when start == 1
	output data_out,																// TX buffer
	output tx_ready																// tx_ready signifies the availability of TX buffer
   );

	reg [10:0] shift;																// TX buffer
	reg [3:0] state;														
	reg available;																	// signify TX's availability

	assign data_out = shift[0];
	assign tx_ready = available;

always @(posedge tx_clk , posedge reset)
	begin
	if (reset)																		// On reset, always set the TX bus high
		begin
		shift <= 10'b1111111111;
		state <= 0;
		available <= 1'b1;
		end 
	else if (start == 0 && state == 0)										// Wait for start signal
		begin
		state <= 0;
		available <= 1;
		end
	else if (start == 1 && state == 0)										// When start signal comes, prepare the data to send, move to next state
		begin
	   shift <= {1'b1,data_in,1'b0,1'b1};							
		state <= 1;
		available <= 0;
		end
	else if (state == 12 && start == 1)										// Wait for the start signal to drop before next TX operation
		begin
		state <= 12;
		available <= 0;
		end
	else if (state == 12 && start == 0)										// Move to the waiting state and wait for the next rising of start signal
		begin
		state <= 0;
		available <= 1;
		end
	else																				// send 10 bits of data one at a time
		begin
		available <= 0;
	   state <= state+1'b1;
		shift[0] <= shift [1];
		shift[1] <= shift[2];
		shift[2] <= shift [3];
		shift[3] <= shift [4];
		shift[4] <= shift [5];
		shift[5] <= shift [6];
		shift[6] <= shift [7];
		shift[7] <= shift [8];
		shift[8] <= shift [9];
		shift[9] <= shift [10];
		shift[10] <= 1'b1;
		end
	end
	   
endmodule 