module pulse_strecher #(parameter STRETCH = 8)
                        (input clk,
                        input pulse_in,
                        input rst_n,
                        output reg pulse_out
                        );
    reg [$clog2(STRETCH)-1:0] cnt;

    always @ (posedge clk or negedge rst_n) begin

        if (!rst_n) begin
        pulse_out <=1'b0;
        cnt <={STRETCH{1'b0}};
        end

        else if (pulse_in) begin
        cnt <= STRETCH -1'b1;
        pulse_out <= 1'b1;
        end

        else if (cnt != 1'b0) begin
        cnt <= cnt -1'b1;
        pulse_out <= 1'b1;
        end

        else
        pulse_out <= 1'b0;
    end
endmodule