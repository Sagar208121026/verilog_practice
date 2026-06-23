module toggle_sync (
                    input clk_src,
                    input clk_dst,
                    input rst_n,
                    input src_pls,
                    output reg dst_pls
);

reg toggle, sync1, sync2;

always @(posedge clk_src or negedge rst_n) begin

    if (~rst_n) begin
        toggle <=0;
    end

    else if (src_pls)
    toggle <= ~toggle;

    else
    toggle <= toggle;
end

always @ (posedge clk_dst or negedge rst_n) begin

    if (~rst_n) begin
        
        sync1 <=0;
        sync2 <=0;
    end

    else begin
    sync1 <= toggle;
    sync2 <= sync1;
    end

end

    always @(*) begin
   dst_pls = sync1 ^ sync2;
end

endmodule