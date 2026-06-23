module bin2gray #(
    parameter PTR_W = 4
)(
    input  [PTR_W-1:0] bin,
    output [PTR_W-1:0] gray
);

assign gray = bin ^ (bin >> 1);

endmodule