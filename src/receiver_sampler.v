`timescale 1ns / 1ns

// Error checking by sampling multiple times of one bit data
module receiver_sampler(
	input rst,
	input sample_clk,
	input rx_clk,
	input RsRx,
	output reg data_bit = 1'b1
   );

	reg [3:0] zero_counter;
	reg [3:0] one_counter;
	reg prev_rx_clk;
	
	wire rx_clk_rising;
	
	assign rx_clk_rising = (prev_rx_clk == 0 && rx_clk == 1);

always@(posedge sample_clk)
	begin
		prev_rx_clk <= rx_clk;
		
		if (rst || rx_clk_rising)
			begin
			zero_counter <= 4'd0;
			one_counter <= 4'd0;
			end
		else if (RsRx == 1'b1)
			one_counter <= one_counter + 1'b1;
		else
			zero_counter <= zero_counter + 1'b1;
	end
	
always@(posedge rx_clk)
	begin
		if(rst)
			data_bit <= 1'b1;
		else if(zero_counter >= one_counter)
			data_bit <= 1'b0;
		else
			data_bit <= 1'b1;	
	end

endmodule
