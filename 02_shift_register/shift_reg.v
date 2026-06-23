module shift_reg # (parameter WIDTH = 8 )
                    (input clk,
                    input rst_n,
                    input serial_in,
                    input shift_en,
                    output reg [WIDTH-1:0] data_out
                    );

    always @ (posedge clk or negedge rst_n) begin
        
        if (~rst_n)
            data_out <= {WIDTH{1'b0}};
        else if (shift_en)
        data_out <= {data_out[WIDTH-2:0], serial_in};

    end


endmodule