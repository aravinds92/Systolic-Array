`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   18:34:12 11/11/2015
// Design Name:   systolic
// Module Name:   X:/Desktop/Lab 5 UART_code/UART/UART/systolic_test.v
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

module systolic_test;

	// Inputs
	reg [7:0] in_data;
	reg clk;
	reg start;

	// Outputs
	wire [7:0] sum_out;
	wire [13:0] ws;
	wire we;
	wire sys_finish;
	// Instantiate the Unit Under Test (UUT)
	systolic uut (
		.sum_out(sum_out), 
		.in_data(in_data), 
		.clk(clk), 
		.start(start), 
		.ws(ws), 
		.we(we),
		.sys_finish(sys_finish)
	);
always #5 clk=~clk;
	initial begin
		// Initialize Inputs
		in_data = 0;
		clk = 0;
		start = 0;
		#20
		start =1;
		in_data=1;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here

	end
      
endmodule

