module main (
	input clk,

	input but1,
	input but2,
	
	output led0,
	output led1,
	output led2,

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
	output SEL5
	);

	reg [24:0] cnt;
	reg [5:0] cnt2;
	assign led0 = cnt[24];
	
	always @(posedge clk) begin
		cnt <= cnt + 1'b1;
	end

	always @(posedge cnt[24]) 
		cnt2 <= cnt2 + 1'b1;

	seven_seg display (
	.clk(clk),
	.digit0(5'd20),
	.digit1(5'd20),
	.digit2(cnt2),
	.digit3(5'd20),
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