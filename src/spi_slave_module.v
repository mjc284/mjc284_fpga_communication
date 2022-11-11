module spi_slave_module(
    input trig_read,
    input trig_write,
    input [7:0] din,
    output [7:0] dout,

    input clk,
    input ss,
	 input miso,
	 input mosi,
	 input sck
);

   wire [7:0] spi_data;
	wire [7:0] fifo_in_data;
	wire spi_trig_write;
	wire spi_trig_read;
	spi_slave SPI_SLAVE(
		.clk(clk),
		.din(fifo_in_data), 
		.dout(spi_data), 
		.trig_read(spi_trig_read),
		.trig_write(spi_trig_write),
	
		.ss(ss),
		.mosi(mosi),
		.miso(miso),
		.sck(sck)
	);
		
	fifo FIFO_IN(
		.clk(clk),
		.din(din),
		.trig_read(spi_trig_read),
		.trig_write(trig_write),
		.dout(fifo_in_data)
	);

	wire [7:0] fifo_out_data;
	fifo FIFO_OUT(
		.clk(clk),
		.din(spi_data),
		.trig_read(trig_read),
		.trig_write(spi_trig_write),
		.dout(dout)
	);

endmodule