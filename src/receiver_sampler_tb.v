`timescale 1ns / 1ns

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   17:09:58 10/30/2015
// Design Name:   receiver_sampler
// Module Name:   X:/Desktop/UART/UART/receiver_sampler_tb.v
// Project Name:  UART
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: receiver_sampler
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module receiver_sampler_tb;

	// Inputs
	reg rst;
	reg sample_clk;
	reg rx_clk;
	reg RsRx;

	// Outputs
	wire data_bit;

	// Instantiate the Unit Under Test (UUT)
	receiver_sampler uut (
		.rst(rst), 
		.sample_clk(sample_clk), 
		.rx_clk(rx_clk), 
		.RsRx(RsRx), 
		.data_bit(data_bit)
	);

	always #1 sample_clk = ~sample_clk;
	always #8 rx_clk = ~rx_clk;

	initial begin
		// Initialize Inputs
		rst = 1;
		sample_clk = 0;
		rx_clk = 0;
		RsRx = 0;

		// Wait 100 ns for global reset to finish
		#104;
		rst = 0;
		
		#16 RsRx = 1;
		#16 RsRx = 0;
		#16 RsRx = 1;
		#16 RsRx = 0;
		#16 RsRx = 1;
		#16 RsRx = 0;
		#16 RsRx = 1;
		#16 RsRx = 0;
		#16 RsRx = 1;
		#16 RsRx = 0;
		#16 RsRx = 1;
		#16 RsRx = 0;

        
		// Add stimulus here

	end
      
endmodule

