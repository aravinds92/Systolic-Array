`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    00:13:19 11/17/2015 
// Design Name: 
// Module Name:    semi_systolic 
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
module semi_systolic(clk, rst, d, r, ready, start);
input clk, rst, start;
input [7:0] d;
output wire [7:0] r;
output wire ready;
reg [7:0] d1, d2, d3, d4, d5, d6, d7, d8, d9; 
wire [15:0] r1, r2, r3, r4, r5, r6, r7, r8, r9;
wire [15:0] r_temp1;
wire [15:0] r_temp2;
reg [3:0] cnt;
reg [15:0] i;
reg b1, b2, b3, b4, b5, b6, b7, b8, b9;
reg m1, m2, m3, m4, m5, m6, m7, m8, m9;
//module systolic(r, w, clk, d, rst);
systolic S1(r1, 16'd1, clk, d1, rst, b1, m1);
systolic S2(r2, 16'd2, clk, d2, rst, b1, m1);
systolic S3(r3, 16'd1, clk, d3, rst, b1, m1);
systolic S4(r4, 16'd2, clk, r1, rst, b2, m2);
systolic S5(r5, 16'd4, clk, r2, rst, b2, m2);
systolic S6(r6, 16'd2, clk, r3, rst, b2, m2);
systolic S7(r7, 16'd1, clk, r4, rst, b3, m3);
systolic S8(r8, 16'd2, clk, r5, rst, b3, m3);
systolic S9(r9, 16'd1, clk, r6, rst, b3, m3);

always@(posedge clk)
begin
	if(rst)
	begin
	cnt<=0;
	i<=0;
	end	
	else
	if(start==1)
	begin
	i<=i+1;	
	cnt<= cnt+1;
	if(cnt==8)
		cnt<=0;
	end	
end

always@(posedge clk)
begin
	if(!rst)
	begin
		if(cnt==0)
			begin
				d1<=d;
				b3<=0;
				m3<=1;
				b2<=0;
				m2<=1;
				b1<=0;
				m1<=1;
			end	
			
		else
		if(cnt==1)
				d2<=d;
		else
		if(cnt==2)
			begin
				d3<=d;
				b3<=0;
				m3<=0;
				b2<=0;
				m2<=0;
				b1<=0;
				m1<=0;
			end
		else
		if(cnt>2 && cnt<6)
		begin
			b1<=1;
			m1<=0;
		end
		else
		if(cnt>5 && cnt<9)
		begin
			b2<=1;
			m2<=0;
			b1<=1;
			m1<=0;
		end	
	end	
end
/*always@(posedge clk)
begin
	if(rst)
		begin
			r_temp1<=0;
			i<=0;
		end	
	else	
		begin
		if(i<9)
			if(cnt==0)
				d1<=d;
			else 
			if(cnt ==1)
					d2<=d;
			else 
			if(cnt ==2)
					d3<=d;
			else 
			if(cnt ==3)
					d4<=d;
			else 
			if(cnt ==4)
					d5<=d;
			else 
			if(cnt ==5)
					d6<=d;
			else 
			if(cnt ==6)
					d7<=d;
			else 
			if(cnt ==7)
					d8<=d;
			else 
			if(cnt ==8)
					d9<=d;
			else
			if(cnt == 9)
					cnt <= 0;
			cnt = cnt + 1;		
			i <= i+1;
		end
end		*/
assign r_temp1=rst?7'd0:(cnt==1)? 7'd0 : (r1+r2+r3+r4+r5+r6+r7+r8+r9);
assign r = r_temp1>>4;
assign ready=rst?1'd0:(cnt==2 && i>8)?1:0;
//assign r_temp2 = r_temp1>>4;
//assign r=r_temp2[7:0];
		
endmodule
