module universal_shift_reg #(
    parameter WIDTH = 8
)(
    input clk,
    input rst_n,

    input serial_left,
    input serial_right,

    input [WIDTH-1:0] parallel_in,

    input [1:0] mode,

    output reg [WIDTH-1:0] data_out
);

always @(posedge clk or negedge rst_n) begin

    if(!rst_n)
        data_out <= {WIDTH{1'b0}};

    else begin
        case(mode)

            2'b00: begin
                data_out <= data_out;     // Hold
            end

            2'b01: begin
                data_out <= {data_out[WIDTH-2:0],
                             serial_right}; // Shift Left
            end

            2'b10: begin
                data_out <= {serial_left,
                             data_out[WIDTH-1:1]}; // Shift Right
            end

            2'b11: begin
                data_out <= parallel_in;   // Parallel Load
            end

        endcase
    end

end

endmodule