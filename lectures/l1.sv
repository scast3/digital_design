module majority (
    input  logic a,
    input  logic b,
    input  logic c,
    output logic f
);

    logic s1, s2, s3;

    assign s1 = a & b;
    assign s2 = b & c;
    assign s3 = a & c;

    assign f = s1 | s2 | s3;

endmodule
