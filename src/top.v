`timescale 1ns / 1ns


module top(
	input clk,
	input rst,
	input RsRx,																			// Connect to RX pin
	output [7:0] Rx_data,															// Received data
	output RsTx,																		// Connect to TX pin
	//output scan_start
	output wire sys_finish
   );

	parameter NUM_DATA = 2500;													// Total number of data points
	parameter CLK_RATE = 9600000;													// Input CLK freq
	parameter BAUD_RATE = 9600;													// UART Baud rate
	parameter SAMPLE_RATE = 10;													// Sampling time per bit

	wire collect_finish_display;
	wire clk_9_6M;
	wire uart_clk;
	wire sample_clk;
	wire sampler_data_out;
	wire tx_ready;																		// tx_ready signifies the availability of TX buffer
	wire rx_ready;																		// when signal == 1, signifies that one byte of data is received
	wire [7:0] rx_data;																// Received data
	wire [7:0] tx_data;
	wire tx_start;																		// start to send data when this bit is set to 1

	wire data_collection_finish;
	wire data_send_finish;
	wire data_send_run;
	wire MEM_we;
	wire [13:0] MEM_wr_sel;
	wire [13:0] MEM_rd_sel;
	wire [7:0] MEM_wr_data;
	wire [7:0] MEM_rd_data;
	wire [7:0] wd, rd, data_out;
	wire [13:0] ws, rs;
	wire we, scan_start;
	wire [7:0] ss1;
	wire [13:0] ss2,ss3;
	wire ss4;
// 	MEM M2(clk, we, ws, rs, sum_out[7:0], rd);
//		scan S1(rs, rd, data_out, clk, data_collection_finish, scan_start); // we need to change the names 
//		systolic sys(sum_out, data_out, clk, scan_start, we, ws);

	assign Rx_data = rx_data;

	Data_Process Data_process(														// Collect data, process it, and send it back
		.clk(clk_9_6M), //clk_9_6M was there
		.rst(rst),
		.data_collection_finish(sys_finish),
		.data_send_finish(data_send_finish),
		.data_send_run(data_send_run)
   );
	
	Data_collect 																		// Collect all the data from PC by UART
	#(.NUM_DATA(NUM_DATA))
	Data_collect(														
		.clk(clk_9_6M), // why is it 9.6 MHz???
		.rst(rst),
		.data_input(rx_data),
		.data_ready(rx_ready),
		.MEM_write_enable(MEM_we),//changed from MEM_we
		.MEM_write_addr(MEM_wr_sel),	//changed from MEM_wr_sel
		.MEM_write_data(MEM_wr_data),		//changed from MEM_wr_data
		.finish(data_collection_finish),
		.collect_finish_display(collect_finish_display)
   );

	Data_send																			// Send all data back to PC by UART
	#(.NUM_DATA(NUM_DATA))
	Data_send(
		.clk(clk_9_6M), // why did u send data at 9.6Mz??
		.rst(rst),
		.send_start(data_send_run),
		.tx_ready(tx_ready),
		.MEM_data(rd),		//changed from rd															// Changed to read data from second memory module
		.MEM_read_sel(rs),//changed from rs
		.transmitter_data(tx_data),
		.transmitter_start(tx_start),
		.finish(data_send_finish)
   );
	

/*assign MEM_wr_data = scan_start? ss2 : ss1;
assign MEM_wr_sel = scan_start? ws : ss3;
assign MEM_we = scan_start ? we : ss4;
*/
	receiver_sampler sampler(														// Error checking logic
		.rst(rst),
		.sample_clk(sample_clk),
		.rx_clk(uart_clk),
		.RsRx(RsRx),
		.data_bit(sampler_data_out)
		);

   receiver receiver(																// UART Receiver
		.data_in(sampler_data_out),
		//.data_in(RsRx),
		.rx_clk(uart_clk),
		.reset(rst),
		.signal(rx_ready),
		.data_out(rx_data)
		);	
	
	transmitter transmitter(														// UART Transmitter
		.data_in(tx_data),
		.tx_clk(uart_clk),
		.reset(rst),
		.start(tx_start),
		.data_out(RsTx),
		.tx_ready(tx_ready)
		);						
	
	clk_divide																			// Clock generator for TX and RX
	#( .CLK_RATE(CLK_RATE),
		.BAUD_RATE(BAUD_RATE),
		.SAMPLE_RATE(SAMPLE_RATE))
	clk_div(																
		.clk(clk_9_6M),
		.rst(rst),
		.clk_uart(uart_clk),
		.clk_sampling(sample_clk)
		);															
	
	PLL_9_6M PLL(																		// PLL that generate 9.6 MHz clk
		.clk_in(clk),
		.clk_out_9_6M(clk_9_6M),
		.rst(rst)
		);
		
	MEM																					// MEM module, MEM read has no delay in this design
	#(.NUM_DATA(NUM_DATA))
	MEM(
		.clk(clk_9_6M),
		.wr_enable(MEM_we),
		.write_select(MEM_wr_sel),
		.read_select(MEM_rd_sel),
		.write_data(MEM_wr_data),
		.read_data(MEM_rd_data)
   );
	
MEM M2(clk_9_6M, we, ws, rs, wd, rd);	//changed from 9.6Mhz
//module MEM(input clk,input wr_enable,input [13:0] write_select,input [13:0] read_select,input [7:0] write_data,output [7:0] read_data);

//scan S1(MEM_rd_sel, MEM_rd_data, clk_9_6M, collect_finish_display, rst, ws, we, wd, sys_finish); // we need to change the names // clk_9_6M was there
//module scan(read_select, read_data, clk, start, rst, ws, we, wd, sys_finish);

//systolic sys(sum_out, data_out, clk_9_6M, scan_start, ws, we, sys_finish, rst);
//systolic sys(sum_out, MEM_rd_sel, clk_9_6M, scan_start, ws, we, sys_finish, rst);

//systol_new1 sys(MEM_rd_sel, wd, sys_finish, collect_finish_display, clk_9_6M, rst, we, ws); 
//module systol_new1(read_select, result, finish, start, read_data, clk, rst);

//module systol_new1(read_select, result, finish, start, read_data, clk, rst, we, ws);

systol_new1 a1 (MEM_rd_sel, wd, sys_finish, collect_finish_display, MEM_rd_data, clk_9_6M, rst, we, ws);
//module scan_new(read_select, start, clk, rst, rd, wd, ws, we, finish);
//scan_new s1(MEM_rd_sel, collect_finish_display, clk_9_6M, rst, MEM_rd_data, wd, ws, we, sys_finish);


endmodule
