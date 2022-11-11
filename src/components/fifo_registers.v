module fifo_registers(
    input [7:0] din,
    input [1:0] sel,
    input clk,
    output [7:0] dout
);

    reg [7:0] data_A = 8'b0;
    reg [7:0] data_B = 8'b0;
    reg [7:0] data_C = 8'b0;
    reg [7:0] data_D = 8'b0;

    always @(posedge clk) begin
        data_A <= din;
        data_B <= data_A;
        data_C <= data_B;
        data_D <= data_C;
    end

    assign dout = ( sel[1]& sel[0]) ? data_D :
                  ( sel[1]&!sel[0]) ? data_C :
                  (!sel[1]& sel[0]) ? data_B :
                  data_A;

endmodule