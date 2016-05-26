`timescale 1ns / 1ns

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   15:37:31 11/02/2015
// Design Name:   MEM
// Module Name:   C:/Users/Ethan/Desktop/UART/UART/MEM_tb.v
// Project Name:  UART
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: MEM
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module MEM_tb;

	// Inputs
	reg clk;
	reg wr_enable;
	reg [13:0] write_select;
	reg [13:0] read_select;
	reg [7:0] write_data;

	// Outputs
	wire [7:0] read_data;

	// Instantiate the Unit Under Test (UUT)
	MEM uut (
		.clk(clk), 
		.wr_enable(wr_enable), 
		.write_select(write_select), 
		.read_select(read_select), 
		.write_data(write_data), 
		.read_data(read_data)
	);

	always #1 assign clk = ~clk;

	initial begin
		// Initialize Inputs
		clk = 0;
		wr_enable = 0;
		write_select = 0;
		read_select = 0;
		write_data = 0;

		// Wait 100 ns for global reset to finish
		#10;
		wr_enable = 1;
		write_select = 1;
		write_data = 9;
		
		#10;
      wr_enable = 0;
		read_select = 1;
		// Add stimulus here

	end
      
endmodule

