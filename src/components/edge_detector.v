module edge_detector(
    input clk,
    input in,
    output out
    );   

    reg A = 1'b0;
    reg B = 1'b0;
    wire nclk = !clk;

    always @(negedge clk) 
        A <= in;

    always @(negedge clk)
        B <= A;

    assign out = A & !B;

endmodule