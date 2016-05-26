`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:38:18 11/17/2015 
// Design Name: 
// Module Name:    scan_new 
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
module scan_new(read_select, start, clk, rst, rd, wd, ws, we, finish);

input clk,rst,start;
input [7:0] rd;
output wire finish;
output reg [13:0] read_select, ws;
output reg  we;
output reg [7:0] wd;
reg [15:0] i,k,l,m;
reg flag, flag1;
wire [7:0] result;
reg [7:0] result_temp;
reg sys_start, scan_start;
reg [13:0]ws1;
reg we1;
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
				flag <= 0;
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
		we<=we1;
		ws<=ws1;
		wd<=0;
		flag1<=1;
	end
	else if(ready==0 && flag1==1)
	begin
		we<=we1;
		wd <= result;
	end
	if(ready==1 && flag1==1)
	begin
		we<=we1;
		ws<=ws1;
	end	
	if(ws == 2499)
	flag1<=0;
end

always@(posedge clk)
begin 
	if(rst)
	begin
	we1<=0;
	ws1<=0;
	end
	else if(ready==0 && flag1==1)
		begin
			we1<=0;
		end
	if(ready==1 && flag1==1)
	begin
		we1<=1;
		ws1<=ws1+1;
	end

end

	
/*always@(posedge clk)
begin
	if(ready)
		result_temp = result;
end*/		
assign finish = (ws==2499)?1'd1:1'd0;
//module semi_systolic(clk, rst, d, r, ready, start);
semi_systolic ssc1 (clk, rst, rd, result, ready, scan_start);
endmodule
