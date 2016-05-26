`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:35:06 10/23/2015 
// Design Name: 
// Module Name:    clk_divide 
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
module clk_divide(
    input clk,
	 input rst,
	 output clk_uart,
	 output clk_sampling
    );

	parameter CLK_RATE = 9600000;
	parameter BAUD_RATE = 19200; // it was 19200 before
	parameter SAMPLE_RATE = 10;

	
	wire [15:0] counter_uart_max; 
	wire [15:0] counter_sampling_max;	

	reg [16:0] counter_uart;
	reg clk_uart_internal;
	reg [16:0] counter_sampling;
	reg clk_sampling_internal;

	assign counter_uart_max = CLK_RATE/BAUD_RATE/2-1;
	assign counter_sampling_max = CLK_RATE/BAUD_RATE/SAMPLE_RATE/2-1;

	assign clk_uart = clk_uart_internal;
	assign clk_sampling = clk_sampling_internal;


	always@(posedge clk)
		begin
		if (rst == 1)
			begin
			counter_uart <= 0;
			clk_uart_internal <= 0;
			end
		else
			begin
			if (counter_uart == counter_uart_max)        // Comment this line if you want to use the testbench
			//if (counter_uart == 15)
				begin
				counter_uart <= 0;
				clk_uart_internal <= ~clk_uart_internal;
				end
			else 
				counter_uart <= counter_uart+1'b1;
			end
		end
		
	
	always@(posedge clk)
		begin
		if (rst == 1)
			begin
			counter_sampling <= 0;
			clk_sampling_internal <= 0;
			end
		else
			begin
			if (counter_sampling == counter_sampling_max)		// Comment this line if you want to use the testbench
			//if (counter_sampling == 1) 
				begin
				counter_sampling <= 0;
				clk_sampling_internal <= ~clk_sampling_internal;
				end
			else 
				counter_sampling <= counter_sampling+1'b1;
			end
		end



endmodule
