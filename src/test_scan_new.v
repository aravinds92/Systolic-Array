`timescale 1ns / 1ns

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   19:42:11 11/17/2015
// Design Name:   scan_new
// Module Name:   X:/Desktop/lab5_working/UART/test_scan_new.v
// Project Name:  UART
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: scan_new
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module test_scan_new;

	// Inputs
	reg start;
	reg clk;
	reg rst;

	// Outputs
	wire [13:0] read_select;
	wire scan_start;

	// Instantiate the Unit Under Test (UUT)
	scan_new uut (
		.read_select(read_select), 
		.scan_start(scan_start), 
		.start(start), 
		.clk(clk),
		.rst(rst)
	);

always #1 clk = ~clk;
	initial begin
		// Initialize Inputs
		start = 0;
		clk = 0;
		rst = 1;
		// Wait 100 ns for global reset to finish
		#100
		start = 1;
		rst = 0;
		
		
		#100000000 $finish;
        
		// Add stimulus here

	end
      
endmodule

