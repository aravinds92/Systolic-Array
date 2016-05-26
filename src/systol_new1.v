`timescale 1ns / 1ns

module systol_new1(read_select, result, finish, start, read_data, clk, rst, we, ws);

input start,clk,rst;
input [7:0] read_data; //
output reg [13:0]read_select;
output wire [13:0] ws;
output [7:0]result;

output reg finish;
output wire we;
//parameter read_data = 150; //

wire [13:0] result_temp;
reg [13:0] result_1;
reg [7:0] d1,d2,d3;
reg [15:0] i ;
reg [13:0] j ;
reg [13:0] k ;
reg [13:0] l ;
reg [13:0] cnt;
wire cnt1;
reg [13:0] address;
reg [7:0] w1,w2,w3,w4,w5,w6,w7,w8,w9;//w1=1,w2=2,w3=1,w4=2,w5=4,w6=2,w7=1,w8=2,w9=1;
reg flag1,flag2;
wire flag;
reg [13:0] sr;
reg [7:0] result_copy;
reg [13:0] ws1, ws2;
reg we1, we2;
assign flag=flag1|flag2;
always@(posedge clk)
begin
if(rst)
begin
	d1<=0;
	d2<=0;
	d3<=0;
	i<= 0;
	j<= 50;
	k<=100;
	l<=0;
	cnt<=0;
	address<=0;
	w1<=1;
	w2<=2;
	w3<=1;
	w4<=2;
	w5<=4;
	w6<=2;
	w7<=1;
	w8<=2;
	w9<=1;	
	flag1<=0;
	flag2<=0;
	sr<=0;
	ws1<=0;
	we1<=0;
end
else if(!rst)
begin
	if(start==1 && k<2500)
	begin
		if (i%3 == 0)
			begin
			//address <= address + 1;
			read_select <= l;
			i <= i+1;
			l<=l+1;
			cnt <= cnt+1;
			d2 <= read_data;
			//we <= 0;
			end
		else if (i%3 == 1 && i!=0)
			begin
			read_select <= j;
			i <= i+1;
			j <= j+1;
			cnt <= cnt+1;
			d3 <= read_data;
			//we <= 0;
			end
		else if (i%3 == 2 && i!=0)
			begin
			read_select <= k;
			i <= i+1;
			k <= k+1;
			cnt <= cnt+1;
			d1 <= read_data;
			//we <= 0;
			end
		if(cnt == 8)
			begin
				cnt <= 0;	
				l<=l-2'd2;
				j<=j-2'd2;
				k<=k-2'd1;
			end
	end
	else
	if(k==2500)
		flag1<=1;
	if(flag1==1 && sr<50)
		begin
			read_select<=sr;
			result_copy<=read_data;
			ws1<=sr-2;
			we1<=1;
			sr<=sr+1;
		end	
	if(sr==50)
		begin
			flag2<=1;
			flag1<=0;
			we1<=0;
			sr<=14'd2449;
		end
	if(flag2==1 && sr<2500)
		begin
			read_select<=sr;
			result_copy<=read_data;
			ws1<=sr;
			we1<=1;
			sr<=sr+1;
		end
	if(sr == 2500)
		begin
			we1<=0;
			flag2<=0;
		end	
	end
end

always@(*)
begin
if(rst)
	finish <= 0;
else
/*if(i>8)
ws <= (i/9)-1;
else
ws <= 0;*/
if(k==2500)
finish <= 1;
else
finish <= 0;
end

/*always@(posedge clk)
begin
if(start==1)
begin
	if(cnt == 0 && i!=0)
		begin
		result_1 <= 0;
		ws<=ws+1;
		we<=0;
		end
	else if(i==0)
		begin
		result_1 <= 0;
		ws<=0;
		we<=0;
		end
	if(cnt>0)
		begin		
			if(cnt==3)
			begin
			result_1 <= result_1 + w1*d1+w2*d2+w3*d3;
			end
		else 
			if(cnt==6)
			begin
			result_1 <= result_1 + w4*d1+w5*d2+w6*d3;
			end
		else 
			if(cnt ==9)
			begin
			result_1 <= result_1 + w7*d1+w8*d2+w9*d3;
			we <= 1;
			end	
	end
	end
end	
*/

always@(negedge clk)
begin
if(rst)
	begin
		ws2<=50;
		we2<=0;
		result_1 <= 8'h00;
	end

else if(start == 1)
	begin
		if(cnt==3)
		begin
			result_1<=result_1+w1*d1+w2*d2+w3*d3;
		end	
		else if(cnt == 6)
		begin
			result_1<=result_1+w4*d1+w5*d2+w6*d3;
		end	
		else if(cnt == 0 && i>0)
		begin
			result_1<=result_1+w7*d1+w8*d2+w9*d3;
		end
		else if(cnt == 1 && i>8)
		begin
			we2<=1;
			ws2<=ws2+1;
		end
		else if(cnt == 2)
		begin
			result_1 <= 0;
			we2<=0;
		end
	end
	
	
end
assign we= flag?we1:we2;
assign ws= flag?ws1:ws2;
assign result_temp = result_1>>4;
assign result = flag?result_copy:result_temp[7:0];	//assign ws = address[13:0];
//assign result = d1;
//assign result = 8'd127;
endmodule


