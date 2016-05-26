`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:41:49 11/17/2015 
// Design Name: 
// Module Name:    semi_systolic_final 
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
module semi_systolic_final(read_select,scan_start, start, clk,rst);

input clk,rst,start;
output reg [13:0] read_select;
output reg scan_start;
reg [15:0] i,k,l,m;
reg flag;
always@(posedge clk)
begin
if(rst)
begin
	scan_start<=0;
	i<=0;
	k<=0;
	l<=50;
	m<=100;
	flag<=1;
end
else if(start ==1)
begin
	if(flag == 1)
	begin
		/*x1=x1+1;
		if(x1%1600==0)
		begin*/
			if(i%3==0)
				begin
					read_select <= k;
					k<=k+1;
					i<=i+1;
				end
			else if(i%3==1)
				begin
					read_select <= l;
					l <= l+1;
					i<=i+1;
				end
			else if(i%3==2)
				begin
					read_select <= m;
					m <= m+1;
					i<=i+1;
				end
			if(i == 8)
				begin
				i <= 0;
				k<=k-2;
				l<=l-2;
				m<=m-1;
				end
			if(m == 2500)
				flag = 0;
			if(k>0)
				scan_start<=1;
			end
		//end			
end
end
endmodule
