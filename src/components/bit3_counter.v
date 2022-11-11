module bit3_counter(
    input clk_fast,
    input clk_slow,
    input mode,
    output one,
    output zero
);

    reg [2:0] cnt = 3'b111;
    wire clk = mode&clk_fast | !mode&clk_slow;

    always @(posedge clk) begin
        cnt[2] <= cnt[2]&!cnt[1]&!mode | cnt[2]&!cnt[0]&!mode | !cnt[2]&cnt[1]&cnt[0]&!mode;
        cnt[1] <= !cnt[1]&cnt[0]&!mode | cnt[1]&!cnt[0]&!mode;
        cnt[0] <= !cnt[0]&!mode;
    end

    assign one = &cnt;
    assign zero = !(|cnt);

endmodule

/*
Description: 3 bit counter with reset.

Resources Usage: 6 LE
*/