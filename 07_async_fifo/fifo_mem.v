module fifo_mem #(
    parameter DATA_W = 8,
    parameter ADDR_W = 4,
    parameter DEPTH  = 16
)(
    input                   wr_clk,
    input                   wr_en,
    input                   rd_clk,
    input                   rd_en,

    input  [ADDR_W-1:0]     wr_addr,
    input  [ADDR_W-1:0]     rd_addr,

    input  [DATA_W-1:0]     wr_data,
    output reg [DATA_W-1:0] rd_data
);

reg [DATA_W-1:0] mem [0:DEPTH-1];

always @(posedge wr_clk)
begin
    if(wr_en)
        mem[wr_addr] <= wr_data;
end

always @(posedge rd_clk)
begin
    if(rd_en)
        rd_data <= mem[rd_addr];
end

endmodule