module spi_master (
	input clk,
	input miso,
	input trigger,
	input [7:0] datain,
	
	output [7:0] dataout,
	output mosi,
	output ss
	output sck
	)
	
	reg [8:0] to_send;
	reg [8:0] to_recieve;
	reg [3:0] count;
	reg slave_select;
	
	initial begin
		to_send <= 8'b0;
		count <= 4'b0;
		slave_select <= 1'b1;
	end
	
	assign ss = slave_select;
	assign sck = clk;
	
	always @ (posedge trigger) begin
		to_send [7:0] <= datain;
		to_send [8] <= (^datain);
		mosi <= to_send [0];
		ss <= 1'b0;
	end
	
	always @ (
	
	always @ (posedge sck) begin
		if (s == 1'b0) begin
			mosi <= to_send [count];
			to_recieve [count] <= miso;
		end
	end
				
	always @ (negedge sck) begin
		if (ss == 1'b0) begin
			if (count < 8) begin
				count <= count + 1'b1;
			end
			else begin
				count <= 4'b0;
				start <= 1'b0;
				ss <= 1'b1;
			end
		end
	end
	
	always @ (posedge ss) begin
		if ((^to_recieve) != 0) begin
			to_recieve <= 8'b0;
		end
	end
	
	assign datain = to_recieve [7:0];
	
endmodule
	
	
		