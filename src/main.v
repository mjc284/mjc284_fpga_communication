module main (
	input clk,

	input but_rst,
	input but1,
	input but2,
	input but3,
	
	output led0,
	output led1,
	output led2,
	output led3,

	output LED_A,
	output LED_B,
	output LED_C,
	output LED_D,
	output LED_E,
	output LED_F,
	output LED_G,
	output LED_DP,
	output SEL0,
	output SEL1,
	output SEL2,
	output SEL3,
	output SEL4,
	output SEL5,
	
	input ss,
	input miso,
	input mosi,
	input sck
	);
	/*
	assign led0 = ss;
	assign led1 = miso;
	assign led2 = mosi;
	assign led3 = sck;
	*/

	reg [24:0] cnt;
	reg [5:0] cnt2;
	//assign led0 = cnt[24];
	
	always @(posedge clk) begin
		cnt <= cnt + 1'b1;
	end

	always @(posedge cnt[24]) 
		cnt2 <= cnt2 + 1'b1;

	wire [7:0] spi_data;
	wire trig_write;
	spi_slave SPI_SLAVE(
		.clk(clk),
		.din({8'd5}), 
		.dout(spi_data), 
		.trig_read(led1),
		.trig_write(trig_write),
	
		.ss(ss),
		.mosi(mosi),
		.miso(miso),
		.sck(sck)
	);

	wire [7:0] fifo_data;
	fifo FIFO(
		.clk(clk),
		.din(spi_data),
		.trig_read(cnt[5]),
		.trig_write(trig_write),
		.dout(fifo_data)
	);

	seven_seg display (
	.clk(clk),
	.digit0(5'd20),
	.digit1(5'd20),
	.digit2(5'd20),
	.digit3(fifo_data),
	.digit4(5'd20),
	.digit5(5'd20),
	
	.LED_A(LED_A),
	.LED_B(LED_B),
	.LED_C(LED_C),
	.LED_D(LED_D),
	.LED_E(LED_E),
	.LED_F(LED_F),
	.LED_G(LED_G),
	.LED_DP(LED_DP),
	.SEL0(SEL0),
	.SEL1(SEL1),
	.SEL2(SEL2),
	.SEL3(SEL3),
	.SEL4(SEL4),
	.SEL5(SEL5)
	);
	
endmodule