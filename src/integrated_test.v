`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   20:09:07 11/16/2015
// Design Name:   integrated
// Module Name:   X:/Desktop/lab5_working/UART/integrated_test.v
// Project Name:  UART
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: integrated
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module integrated_test;

	// Inputs
	reg clk;
	reg rst;
	reg start;
	wire finish;
	// Instantiate the Unit Under Test (UUT)
	integrated uut (
		.clk(clk), 
		.rst(rst),  
		.finish(finish),
		.start(start)
	);
always #1 clk=~clk;
	initial begin
		// Initialize Inputs
		clk = 0;
		start=0;
		rst = 1;
		#5
		rst=0;
		#6000
		start=1;
		
	

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here

	end
      
endmodule

