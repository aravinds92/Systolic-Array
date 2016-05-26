`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   15:25:30 11/02/2015
// Design Name:   Data_collect
// Module Name:   C:/Users/Ethan/Desktop/UART/UART/Data_collect_tb.v
// Project Name:  UART
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: Data_collect
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module Data_collect_tb;

	// Inputs
	reg clk;
	reg rst;
	reg [7:0] data_input;
	reg data_ready;

	// Outputs
	wire MEM_write_enable;
	wire [13:0] MEM_write_addr;
	wire [7:0] MEM_write_data;
	wire finish;

	// Instantiate the Unit Under Test (UUT)
	Data_collect uut (
		.clk(clk), 
		.rst(rst), 
		.data_input(data_input), 
		.data_ready(data_ready), 
		.MEM_write_enable(MEM_write_enable), 
		.MEM_write_addr(MEM_write_addr), 
		.MEM_write_data(MEM_write_data), 
		.finish(finish)
	);

	always #1 assign clk = ~clk;
	always #5 assign data_ready = ~data_ready;

	initial begin
		// Initialize Inputs
		clk = 0;
		rst = 1;
		data_input = 1;
		data_ready = 0;

		// Wait 100 ns for global reset to finish
		#100;
		rst = 0;
        
		// Add stimulus here

	end
      
endmodule

