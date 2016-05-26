`timescale 1ns / 1ns


// Send 10000 data back to PC
module Data_send(
	input clk,
	input rst,
	input send_start,						// Start to send data after this bit is set to 1
	input tx_ready,						// Send one byte of data after tx_ready
	input [7:0] MEM_data,
	output reg [13:0] MEM_read_sel,
	output [7:0] transmitter_data,
	output reg transmitter_start,
	output finish
   );
	
	parameter NUM_DATA = 2500;		//changed from 10 to 2500
	
	reg prev_tx_ready;
	reg prev_send_start;
	
	assign transmitter_data = MEM_data;
	assign finish = (MEM_read_sel == NUM_DATA)? 1'b1 : 1'b0;
	
always@(posedge clk)
	begin
	prev_tx_ready <= tx_ready;
	prev_send_start <= send_start;
	
	if(rst || MEM_read_sel == NUM_DATA)
		begin
		MEM_read_sel <= 14'd0;
		transmitter_start <= 1'b0;
		end
	else if(send_start)
		begin
		if(!prev_send_start && tx_ready)
			begin
			MEM_read_sel <= 14'd0;
			transmitter_start <= 1'b1;
			end
		if(tx_ready && prev_tx_ready == 0)					// Send one byte of data on posedge of tx_ready
			begin
			MEM_read_sel <= MEM_read_sel + 1'b1;
			transmitter_start <= 1'b1;
			end
		else if(!tx_ready)										// Clear the start bit after the transmission is start
			begin
			MEM_read_sel <= MEM_read_sel;
			transmitter_start <= 1'b0;
			end
		end
	end

endmodule
