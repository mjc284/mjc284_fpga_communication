module fifo(
    input clk,
    input [7:0] din,
    input trig_read,
    input trig_write,
    output [7:0] dout,
	 output full,
	 output empty
);

wire pre_register_clk;
wire [1:0] pointer;

fifo_pointer FIFO_POINTER(
    .clk(clk),
    .trig_write(trig_write),
    .trig_read(trig_read),
	 .fifo_clk(pre_register_clk),
    .data_pointer(pointer),
	 .full(full),
	 .empty(empty)
);

wire register_clk = pre_register_clk & !full;

fifo_registers FIFO_REGISTERS(
    .din(din),
    .sel(pointer),
    .clk(register_clk),
    .dout(dout)
);

endmodule