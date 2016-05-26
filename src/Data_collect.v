`timescale 1ns / 1ns

// Collect 100*100 data from UART
module Data_collect(
	input clk,
	input rst,
	input [7:0] data_input,
	input data_ready,
	output reg MEM_write_enable,
	output reg [13:0] MEM_write_addr,
	output reg [7:0] MEM_write_data,
	output finish,
	output reg collect_finish_display
   );
	
	parameter NUM_DATA = 2500;
	
	reg [13:0] delayed_write_addr;
	reg prev_data_ready;
	
	assign finish = (MEM_write_addr == NUM_DATA - 1)? 1'b1 : 1'b0;			// Collecion is finished after received 10000 data
	
always@(posedge finish)
	begin
	if(rst)
		collect_finish_display <= 1'b0;
	else
		collect_finish_display <= ~collect_finish_display;
	end
	
always@(posedge clk)
	begin
	prev_data_ready <= data_ready;			// for capturing the rising edge of data_ready
	MEM_write_addr <= delayed_write_addr;
	
	if(rst || MEM_write_addr == NUM_DATA)		// Reset when rst == 1 or saved 10000 data 
		begin
		MEM_write_enable <= 1'b0;
		delayed_write_addr <= 14'd0;
		MEM_write_data <= 8'd0;
		end
	else if(data_ready == 1'b1 && prev_data_ready == 1'b0)
		begin
		MEM_write_enable <= 1'b1;
		delayed_write_addr <= delayed_write_addr + 1'b1;
		MEM_write_data <= data_input;
		end
	else
		begin
		MEM_write_enable <= 1'b0;
		delayed_write_addr <= delayed_write_addr;
		MEM_write_data <= data_input;
		end
	end
endmodule
