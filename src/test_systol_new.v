`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   04:25:23 11/13/2015
// Design Name:   systol_new1
// Module Name:   X:/My Documents/xilinx/UART/test_systol_new.v
// Project Name:  UART
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: systol_new1
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module test_systol_new;

	// Inputs
	reg start;
	reg [7:0] read_data;
	reg clk;
	reg rst;

	// Outputs
	wire [13:0] read_select,ws;
	wire [7:0] result;
	wire finish;
	wire we;

	// Instantiate the Unit Under Test (UUT)
	systol_new1 uut (
		.read_select(read_select), 
		.result(result), 
		.finish(finish), 
		.start(start), 
		.read_data(read_data), 
		.clk(clk), 
		.rst(rst),
		.we(we),
		.ws(ws)
	);
always #5 clk=~clk;
	initial begin
		// Initialize Inputs
		start = 0;
		read_data = 1;
		clk = 0;
		rst = 1;
		#5 rst =0;
		#20
		start = 1;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here

	end
      
endmodule

