module main (
	input clk,

	input but1,
	input but2,
	
	output led1,
	output led2
	);
	/*
	reg [24:0] cnt;
	
	always @(posedge clk) begin
		cnt <= cnt + 1'b1;
	end
*/
	wire [1:0] leds;

	fifo_pointer pointer(
		.clk(clk),
		.trig_write(!but1),
    	.trig_read(!but2),
    	.data_pointer(leds)
	);
	
	assign led1 = leds[0];
	assign led2 = leds[1];
	
endmodule