module sync_bus_2ff #(
    parameter PTR_W = 5
)(
    input                   clk_dst,
    input                   rst_n,

    input  [PTR_W-1:0]      async_in,
    output [PTR_W-1:0]      sync_out
);

reg [PTR_W-1:0] sync1;
reg [PTR_W-1:0] sync2;

always @(posedge clk_dst or negedge rst_n)
begin
    if(!rst_n)
    begin
        sync1 <= 0;
        sync2 <= 0;
    end
    else
    begin
        sync1 <= async_in;
        sync2 <= sync1;
    end
end

assign sync_out = sync2;

endmodule