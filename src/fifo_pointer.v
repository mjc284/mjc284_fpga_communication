module fifo_pointer (
    input clk,
    input trig_write,
    input trig_read,
	 output fifo_clk,
    output [1:0] data_pointer
    );

    wire edge_write;
    edge_detector edge_detector_write(
        .clk(clk),
        .in(trig_write),
        .out(edge_write)
    );
	 assign fifo_clk = edge_write;

    wire edge_read;
    edge_detector edge_detector_read(
        .clk(clk),
        .in(trig_read),
        .out(edge_read)
    );

    reg [4:0] cnt = 5'b1;

    wire sel0 = !edge_read & !edge_write;
    wire sel1 = !edge_read &  edge_write;
    wire sel2 =  edge_read & !edge_write;
    wire sel3 =  edge_read &  edge_write;

    always @(posedge clk) begin
        cnt[0] <= (sel0 & cnt[0]) | (sel1 & 1'b0  ) | (sel2 & (cnt[1] | cnt[0])) | (sel3 & cnt[0]);
        cnt[1] <= (sel0 & cnt[1]) | (sel1 & cnt[0]) | (sel2 & cnt[2]) | (sel3 & cnt[1]);
        cnt[2] <= (sel0 & cnt[2]) | (sel1 & cnt[1]) | (sel2 & cnt[3]) | (sel3 & cnt[2]);
        cnt[3] <= (sel0 & cnt[3]) | (sel1 & cnt[2]) | (sel2 & cnt[4]) | (sel3 & cnt[3]);
        cnt[4] <= (sel0 & cnt[4]) | (sel1 & (cnt[4] | cnt[3])) | (sel2 & 1'b0  ) | (sel3 & cnt[4]);
    end

    assign data_pointer[0] = cnt[1] | cnt[3];
    assign data_pointer[1] = cnt[2] | cnt[3];

endmodule

/*
Description: Pointer that can be incremented or decremented on the positive edge of trig_write or trig_read respectively.
				 The pointer count maxes out at 4 and mins out at 0.
				 
				 EX) Initial State = 2, Press trig_write 3 times:
					  data_pointer: 2 -> 3 -> 4 -> 4
					  
				 EX) Initial State = 2, Press trig_read 3 times:
					  data_pointer: 2 -> 1 -> 0 -> 0

Resources Usage: 15 LE
*/