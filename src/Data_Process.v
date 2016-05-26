`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:50:48 11/02/2015 
// Design Name: 
// Module Name:    Data_Process 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module Data_Process(
	input clk,
	input rst,
	input data_collection_finish,
	input data_send_finish,
	output reg data_send_run
   );
	// This is ethan's code for immediately sending all the data back
	always@(posedge clk)
		begin
		if(rst)
			data_send_run <= 1'b0;
		else if(data_collection_finish)					// After 10000 data is received, send 10000 data back to PC
			data_send_run <= 1'b1;
		else if(data_send_finish)							// After sending is finish, clear the data_send signal
			data_send_run <= 1'b0;
		end
/*

//my code starts here

// data_collection_finish is 1 when matlab is done sending all the image data to fpga memory
// data_send_finish is 1 when FPGA is done sending all the processed data to UART
// data_send_run is the output of this file, when we are done processing the data, we will set the data send run to be 1 so that
// we can send the processed data back to UART

// the major issue is that we have to be sure at what time in seconds we need to start sending data 


parameter data_collecting = 1, data_processing = 2, data_sending = 3;  
wire state = 0;
always@(*)
begin
	case(state)
		0: next_state = data_collecting;
		1: begin 
			if(data_collection_finish)
				next_state = data_processing;
			end
		2: begin
			if(data_process_finish)
			next_state = data_sending;
			end
		default: next_state = 0;
		
		endcase	
		
end

always@(posedge clk)
	state = next_state;
	
//module scan(read_select, read_data, data_out, clk, start, scan_start);
scan S1 (read_select, read_data, data_out, clk, start, scan_start);*/
endmodule
