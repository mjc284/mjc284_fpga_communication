module spi_slave (
	input clk,
	input [7:0] din, 
	output [7:0] dout, 
	output trig_read,
	output trig_write,
	
	input ss,
	input mosi,
	output miso,
	output sck,
	);

	reg [7:0] reg_din = 8'b0;
	reg [7:0] reg_dout = 8'b0;
	assign dout = reg_dout;

	always @(posedge sck) begin
		reg_dout <= {reg_dout[6:0], mosi};
	end

	wire clk_mix;
	wire one;
	always @ (posedge clk_mix) begin
		if(one)
			reg_din <= din;
		else
			reg_din <= {reg_din[6:0], reg_din[7]};
	end
	assign mosi = reg_din[7];
	
	wire zero;
	assign trig_write = zero;
	assign trig_read = one;

	bit3_counter counter(
		.clk_fast(clk),
		.clk_slow(sck),
		.clk_mix(clk_mix),
		.mode(ss),
		.one(one),
		.zero(zero)
	);
	
endmodule