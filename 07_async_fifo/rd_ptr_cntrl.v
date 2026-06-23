module rd_ptr_ctrl #(
    parameter PTR_W = 5
)(
    input                   rd_clk,
    input                   rst_n,
    input                   rd_en,

    input  [PTR_W-1:0]      wr_gray_sync,

    output reg [PTR_W-1:0]  rd_bin,
    output reg [PTR_W-1:0]  rd_gray,
    output                  empty
);

wire [PTR_W-1:0] rd_bin_next;
wire [PTR_W-1:0] rd_gray_next;

assign rd_bin_next =
            rd_bin + (rd_en & ~empty);

assign rd_gray_next =
            rd_bin_next ^ (rd_bin_next >> 1);

always @(posedge rd_clk or negedge rst_n)
begin
    if(!rst_n)
    begin
        rd_bin  <= 0;
        rd_gray <= 0;
    end
    else
    begin
        rd_bin  <= rd_bin_next;
        rd_gray <= rd_gray_next;
    end
end

assign empty =
        (rd_gray_next == wr_gray_sync);

endmodule