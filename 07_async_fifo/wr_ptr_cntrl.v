module wr_ptr_ctrl #(
    parameter PTR_W = 5
)(
    input                   wr_clk,
    input                   rst_n,
    input                   wr_en,

    input  [PTR_W-1:0]      rd_gray_sync,

    output reg [PTR_W-1:0]  wr_bin,
    output reg [PTR_W-1:0]  wr_gray,
    output                  full
);

wire [PTR_W-1:0] wr_bin_next;
wire [PTR_W-1:0] wr_gray_next;

assign wr_bin_next =
            wr_bin + (wr_en & ~full);

/*bin2gray #(
    .PTR_W(PTR_W)
)
u_bin2gray_wr
(
    .bin (wr_bin_next),
    .gray(wr_gray_next)
);*/

assign wr_gray_next =
            wr_bin_next ^ (wr_bin_next >> 1);

always @(posedge wr_clk or negedge rst_n)
begin
    if(!rst_n)
    begin
        wr_bin  <= 0;
        wr_gray <= 0;
    end
    else
    begin
        wr_bin  <= wr_bin_next;
        wr_gray <= wr_gray_next;
    end
end

assign full =
(
    wr_gray_next ==
    {
        ~rd_gray_sync[PTR_W-1:PTR_W-2],
         rd_gray_sync[PTR_W-3:0]
    }
);

endmodule