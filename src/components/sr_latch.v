module sr_latch(
    input s,
    input r,
    output q
    );

    wire nq;

    assign q = !(r|nq);
    assign nq = !(s|q);

endmodule

/*
Resource Usage: 1 LE
*/