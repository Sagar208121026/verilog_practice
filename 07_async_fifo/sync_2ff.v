module sync_2ff (
    input  clk_dst,
    input  rst_n,
    input  async_in,
    output sync_out
);

reg sync1, sync2;

always @(posedge clk_dst or negedge rst_n) begin
    if(!rst_n) begin
        sync1 <= 1'b0;
        sync2 <= 1'b0;
    end
    else begin
        sync1 <= async_in;
        sync2 <= sync1;
    end
end

assign sync_out = sync2;

endmodule