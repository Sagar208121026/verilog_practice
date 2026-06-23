module async_fifo_top #(
    parameter DATA_W = 8,
    parameter ADDR_W = 4,
    parameter DEPTH  = 16,
    parameter PTR_W  = ADDR_W + 1
)(
    input                   wr_clk,
    input                   rd_clk,
    input                   rst_n,

    input                   wr_en,
    input                   rd_en,

    input  [DATA_W-1:0]     wr_data,
    output [DATA_W-1:0]     rd_data,

    output                  full,
    output                  empty
);

//
// Pointer wires
//
wire [PTR_W-1:0] wr_bin;
wire [PTR_W-1:0] wr_gray;

wire [PTR_W-1:0] rd_bin;
wire [PTR_W-1:0] rd_gray;

//
// Synchronized pointers
//
wire [PTR_W-1:0] wr_gray_sync;
wire [PTR_W-1:0] rd_gray_sync;

//
// Synchronize write pointer into read clock domain
//
sync_bus_2ff #(
    .PTR_W(PTR_W)
)
u_sync_wr2rd
(
    .clk_dst (rd_clk),
    .rst_n   (rst_n),

    .async_in(wr_gray),
    .sync_out(wr_gray_sync)
);

//
// Synchronize read pointer into write clock domain
//
sync_bus_2ff #(
    .PTR_W(PTR_W)
)
u_sync_rd2wr
(
    .clk_dst (wr_clk),
    .rst_n   (rst_n),

    .async_in(rd_gray),
    .sync_out(rd_gray_sync)
);

//
// Write pointer controller
//
wr_ptr_ctrl #(
    .PTR_W(PTR_W)
)
u_wr_ptr_ctrl
(
    .wr_clk      (wr_clk),
    .rst_n       (rst_n),
    .wr_en       (wr_en),

    .rd_gray_sync(rd_gray_sync),

    .wr_bin      (wr_bin),
    .wr_gray     (wr_gray),

    .full        (full)
);

//
// Read pointer controller
//
rd_ptr_ctrl #(
    .PTR_W(PTR_W)
)
u_rd_ptr_ctrl
(
    .rd_clk      (rd_clk),
    .rst_n       (rst_n),
    .rd_en       (rd_en),

    .wr_gray_sync(wr_gray_sync),

    .rd_bin      (rd_bin),
    .rd_gray     (rd_gray),

    .empty       (empty)
);

//
// FIFO memory
//
fifo_mem #(
    .DATA_W(DATA_W),
    .ADDR_W(ADDR_W),
    .DEPTH (DEPTH)
)
u_fifo_mem
(
    .wr_clk (wr_clk),
    .wr_en  (wr_en & ~full),

    .rd_clk (rd_clk),
    .rd_en  (rd_en & ~empty),

    .wr_addr(wr_bin[ADDR_W-1:0]),
    .rd_addr(rd_bin[ADDR_W-1:0]),

    .wr_data(wr_data),
    .rd_data(rd_data)
);

endmodule