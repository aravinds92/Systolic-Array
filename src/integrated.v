`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:55:39 11/16/2015 
// Design Name: 
// Module Name:    integrated 
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
module integrated(clk, rst, start, finish);
input clk, rst, start;
output finish;
wire [13:0]ws1, rs1, rs;
reg  we;
wire we1;
reg [13:0] ws;
reg [7:0] wd;
wire [7:0] rd, wd1, rd1;
reg[13:0] i;

MEM M1(clk, we, ws, rs, wd, rd);	//read connected to systol
MEM M2(clk, we1, ws1, rs1, wd1, rd1);	//write connected to systol
//module scan_new(read_select, start, clk, rst, rd, wd, ws, we, finish);
scan_new s1(rs, start, clk, rst, rd, wd1, ws1, we1, finish);

always@(posedge clk)
begin
			if(rst)
			i<=0;
			else if(i<2500)
			begin
				i<=i+1;
				ws<=i;
				wd<=i;
				we<=1;		
			end	
			if(i==2500)
			we<=0;
end		

endmodule
