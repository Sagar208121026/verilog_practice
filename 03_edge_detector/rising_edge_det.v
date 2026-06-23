module rise_edge_det (
    input clk,
    input rst_n,
    input signal_in,
    output pulse_out // generate a pulse when rising edge detected
);

reg d1, d2;

always @(posedge clk or negedge rst_n) begin
    if(!rst_n) begin
        d1 <= 1'b0;
        d2 <= 1'b0;
    end
    else begin
        d1 <= signal_in;
        d2 <= d1;
    end
end

assign pulse_out = d1 & ~d2;
//assign pulse_out = d1 & ~d2; // Negative edge Detector
//assign pulse_out = d1 ^ d2;  // Both edge detector

endmodule