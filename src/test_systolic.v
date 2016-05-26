`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   01:43:26 11/11/2015
// Design Name:   systolic
// Module Name:   X:/Desktop/Lab 5 UART_code/UART/UART/test_systolic.v
// Project Name:  UART
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: systolic
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module test_systolic;

	// Inputs
	reg [7:0] in_data;
	reg clk;

	// Outputs
	wire [15:0] sum_out;

	// Instantiate the Unit Under Test (UUT)
	systolic uut (
		.in_data(in_data), 
		.sum_out(sum_out), 
		.clk(clk)
	);
always #5 clk = ~clk;
	initial begin
		// Initialize Inputs
		in_data = 0;
		clk = 0;
		in_data <= 8'hff;
		#10 in_data <= 8'hff;
		#10 in_data <= 8'hff;
		#10 in_data <= 8'hff;
		#10 in_data <= 8'hff;
		#10 in_data <= 8'hff;
		#10 in_data <= 8'hff;
		#10 in_data <= 8'hff;
		#10 in_data <= 8'hff;
		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here

	end
      
endmodule

