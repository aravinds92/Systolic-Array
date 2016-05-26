`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    00:10:37 11/17/2015 
// Design Name: 
// Module Name:    systolic 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module systolic(r, w, clk, d, rst, bcast, m);
input [15:0] w;
input [7:0] d;
input clk, rst, bcast, m;
output reg [15:0] r;
always@(posedge clk)
begin
	if(rst)
		r <= 0;
	else 
	if(bcast == 1 && m==0)
		r <= d;
	else
	if(bcast == 0 && m==1)
		r <= w*d;
end
endmodule
