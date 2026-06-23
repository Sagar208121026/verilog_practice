module gray2bin #(
    parameter PTR_W = 4
)(
    input  [PTR_W-1:0] gray,
    output reg [PTR_W-1:0] bin
);

integer i;

always @(*) begin
    bin[PTR_W-1] = gray[PTR_W-1];

    for(i = PTR_W-2; i >= 0; i = i - 1)
        bin[i] = bin[i+1] ^ gray[i];
end

endmodule