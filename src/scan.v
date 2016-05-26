`timescale 1ns / 1ns
//////////////////////////////////////////////////////////////////////////////////
// Company: Boston University
// Engineer: 
// 
// Create Date:    23:48:42 11/10/2015 
// Design Name: 
// Module Name:    Scan 
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
module scan(read_select, read_data, clk, start, rst, ws, we, wd, sys_finish);

input [7:0] read_data;
input clk, start, rst;
output reg [13:0] read_select, ws;
output [7:0] wd;
output reg sys_finish, we;
reg scan_start=0,stop=0;
integer i=1,k=0,l=50,m=100,flag=1, x1=0, j=0, z=0;
wire [7:0] w [8:0];
reg [15:0] y2;
wire [15:0]yyy;
reg [15:0] y1 = 0;

assign w[0] = 8'h01;
assign w[1] = 8'h02;
assign w[2] = 8'h01;
assign w[3] = 8'h02;
assign w[4] = 8'h04;
assign w[5] = 8'h02;
assign w[6] = 8'h01;
assign w[7] = 8'h02;
assign w[8] = 8'h01;

always@(posedge clk)
begin
if(rst)
	scan_start<=0;
else if(start ==1)
begin
	if(flag == 1)
	begin
		/*x1=x1+1;
		if(x1%1600==0)
		begin*/
			if(i<4)
				begin
					read_select <= k;
					k<=k+1;
					i<=i+1;
				end
			if(i>3 && i<7)
				begin
					read_select <= l;
					l <= l+1;
					i<=i+1;
				end
			if(i>6 && i<10)
				begin
					read_select <= m;
					m <= m+1;
					i<=i+1;
				end
			if(i == 9)
				i <= 1;
			if(m == 2499)
				flag = 0;
			if(k>0)
				scan_start<=1;
			end
		//end			
end
end

always@(posedge clk)
begin
		if(rst)
		begin
		sys_finish<=0;
		stop<=0;
		end
		else	
		if(scan_start ==1 && stop ==0 )
		begin
			if(z==9)
				begin
					z <= 0;
					ws<=j;
					we<=1;
					j<=j+1;
					y1<=0;
				end	
			else
				begin
					we<=0;
					z <= z+1;
					y1 <= y1 + w[z]*read_data;
				end	
				y2<=y1;
			if(j == 2500)
				begin
					sys_finish <= 1;
					stop <=1;
				end
			else 
			sys_finish <=0;
		end
end	

assign yyy = y2>>4;
assign wd= read_select;

endmodule		