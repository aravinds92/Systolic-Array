`timescale 1ns / 1ns

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   17:51:05 11/02/2015
// Design Name:   top
// Module Name:   C:/Users/Ethan/Desktop/UART/UART/top_tb.v
// Project Name:  UART
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: top
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module top_tb;

	// Inputs
	reg clk;
	reg rst;
	reg RsRx;

	// Outputs
	wire [7:0] Rx_data;
	wire RsTx;

	// Instantiate the Unit Under Test (UUT)
	top uut (
		.clk(clk), 
		.rst(rst), 
		.RsRx(RsRx), 
		.Rx_data(Rx_data), 
		.RsTx(RsTx)
	);

	always #1 assign clk = ~clk;
	always #64 RsRx = ~RsRx;
	initial begin
		// Initialize Inputs
		clk = 0;
		rst = 1;
		RsRx = 1;

		// Wait 100 ns for global reset to finish
		#100;
		rst = 0;
		
		/*#95 RsRx = 1;
		
		#64 RsRx = 1;
		#64 RsRx = 1;
		#64 RsRx = 1;
		#64 RsRx = 1;
		#64 RsRx = 1;
		#64 RsRx = 1;
		#64 RsRx = 1;
		#64 RsRx = 1;
		#64 RsRx = 1;
		#64 RsRx = 1;
		#64 RsRx = 1;
		#64 RsRx = 1;
		#64 RsRx = 1;
		#64 RsRx = 1;
		#64 RsRx = 1;
		#64 RsRx = 0;
		// Send data
		#64 RsRx = 1;
		#64 RsRx = 0;
		#64 RsRx = 0;
		#64 RsRx = 0;
		#64 RsRx = 0;
		#64 RsRx = 0;
		#64 RsRx = 0;
		#64 RsRx = 0;
		
		#64 RsRx = 1;
		#64 RsRx = 1;
		#64 RsRx = 1;
		#64 RsRx = 1;
		#64 RsRx = 1;
		#64 RsRx = 0;
		// Send data
		#64 RsRx = 0;
		#64 RsRx = 1;
		#64 RsRx = 0;
		#64 RsRx = 0;
		#64 RsRx = 0;
		#64 RsRx = 0;
		#64 RsRx = 0;
		#64 RsRx = 0;
		
		#64 RsRx = 1;
		#64 RsRx = 1;
		#64 RsRx = 1;
		#64 RsRx = 1;
		#64 RsRx = 1;
		#64 RsRx = 0;
		// Send data
		#64 RsRx = 1;
		#64 RsRx = 1;
		#64 RsRx = 0;
		#64 RsRx = 0;
		#64 RsRx = 0;
		#64 RsRx = 0;
		#64 RsRx = 0;
		#64 RsRx = 0;
		
		#64 RsRx = 1;
		#64 RsRx = 1;
		#64 RsRx = 1;
		#64 RsRx = 1;
		#64 RsRx = 1;
		#64 RsRx = 0;
		// Send data
		#64 RsRx = 0;
		#64 RsRx = 0;
		#64 RsRx = 1;
		#64 RsRx = 0;
		#64 RsRx = 0;
		#64 RsRx = 0;
		#64 RsRx = 0;
		#64 RsRx = 0;
		
		#64 RsRx = 1;
		#64 RsRx = 1;
		#64 RsRx = 1;
		#64 RsRx = 1;
		#64 RsRx = 1;
		#64 RsRx = 0;
		// Send data
		#64 RsRx = 1;
		#64 RsRx = 0;
		#64 RsRx = 1;
		#64 RsRx = 0;
		#64 RsRx = 0;
		#64 RsRx = 0;
		#64 RsRx = 0;
		#64 RsRx = 0;
		
		#64 RsRx = 1;
		#64 RsRx = 1;
		#64 RsRx = 1;
		#64 RsRx = 1;
		#64 RsRx = 1;
		#64 RsRx = 0;
		// Send data
		#64 RsRx = 0;
		#64 RsRx = 1;
		#64 RsRx = 1;
		#64 RsRx = 0;
		#64 RsRx = 0;
		#64 RsRx = 0;
		#64 RsRx = 0;
		#64 RsRx = 0;
		
		#64 RsRx = 1;
		#64 RsRx = 1;
		#64 RsRx = 1;
		#64 RsRx = 1;
		#64 RsRx = 1;
		#64 RsRx = 0;
		// Send data
		#64 RsRx = 1;
		#64 RsRx = 1;
		#64 RsRx = 1;
		#64 RsRx = 0;
		#64 RsRx = 0;
		#64 RsRx = 0;
		#64 RsRx = 0;
		#64 RsRx = 0;
		
		#64 RsRx = 1;
		#64 RsRx = 1;
		#64 RsRx = 1;
		#64 RsRx = 1;
		#64 RsRx = 1;
		#64 RsRx = 0;
		// Send data
		#64 RsRx = 0;
		#64 RsRx = 0;
		#64 RsRx = 0;
		#64 RsRx = 1;
		#64 RsRx = 0;
		#64 RsRx = 0;
		#64 RsRx = 0;
		#64 RsRx = 0;
		
		#64 RsRx = 1;
		#64 RsRx = 1;
		#64 RsRx = 1;
		#64 RsRx = 1;
		#64 RsRx = 1;
		#64 RsRx = 0;
		// Send data
		#64 RsRx = 1;
		#64 RsRx = 0;
		#64 RsRx = 0;
		#64 RsRx = 1;
		#64 RsRx = 0;
		#64 RsRx = 0;
		#64 RsRx = 0;
		#64 RsRx = 0;
		
		#64 RsRx = 1;
		#64 RsRx = 1;
		#64 RsRx = 1;
		#64 RsRx = 1;
		#64 RsRx = 1;
		#64 RsRx = 0;
		// Send data
		#64 RsRx = 0;
		#64 RsRx = 1;
		#64 RsRx = 0;
		#64 RsRx = 1;
		#64 RsRx = 0;
		#64 RsRx = 0;
		#64 RsRx = 0;
		#64 RsRx = 0;
		
		#64 RsRx = 1;*/

		
	end
      
endmodule

