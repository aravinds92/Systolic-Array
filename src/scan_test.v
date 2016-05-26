`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   00:41:59 11/11/2015
// Design Name:   scan
// Module Name:   X:/Desktop/Lab 5 UART_code/UART/UART/scan_test.v
// Project Name:  UART
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: scan
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module scan_test;

	// Inputs
	reg [7:0] read_data;
	reg clk,rst,start;

	// Outputs
	wire [13:0] read_select;
	wire [7:0] data_out;
	wire scan_start;
	

	// Instantiate the Unit Under Test (UUT)
	scan uut (
		.read_select(read_select), 
		.read_data(read_data), 
		.data_out(data_out), 
		.clk(clk),
		.rst(rst),
		.start(start),
		.scan_start(scan_start)
	);
always #5 clk=~clk;
	initial begin
		// Initialize Inputs
		read_data = 0;
		clk = 0;
		rst=0;
		start=1;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here

	end
      
endmodule

