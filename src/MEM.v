`timescale 1ns / 1ns

// MEM read has no demo in this design

module MEM(
	input clk,
	input wr_enable,
	input [13:0] write_select,
	input [13:0] read_select,
	input [7:0] write_data,
	output reg [7:0] read_data
   );
	
	parameter NUM_DATA = 2499;
	
	reg [7:0] Data [NUM_DATA:0];
	
	always@(posedge clk)
	begin
		 read_data = Data[read_select];
	end

	
	always@(posedge clk)
		begin
		if(wr_enable)
			Data[write_select] <= write_data;
		end

endmodule
