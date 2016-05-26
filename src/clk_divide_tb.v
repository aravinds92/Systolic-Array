`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   16:47:58 10/30/2015
// Design Name:   clk_divide
// Module Name:   X:/Desktop/UART/UART/clk_divide_tb.v
// Project Name:  UART
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: clk_divide
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module clk_divide_tb;

	// Inputs
	reg clk;
	reg rst;

	// Outputs
	wire clk_uart;
	wire clk_sampling;

	// Instantiate the Unit Under Test (UUT)
	clk_divide uut (
		.clk(clk), 
		.rst(rst), 
		.clk_uart(clk_uart), 
		.clk_sampling(clk_sampling)
	);

	always #1 assign clk = ~clk;

	initial begin
		// Initialize Inputs
		clk = 0;
		rst = 1;

		// Wait 100 ns for global reset to finish
		#100;
		rst = 0;
        
		// Add stimulus here

	end
      
endmodule

