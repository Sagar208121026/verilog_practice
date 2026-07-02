module counter #(parameter COUNT = 8)
                (
                    input clk,
                    input rst_n,
                    output reg [$clog2 (COUNT) -1 :0] count
                );

    always @ (posedge clk or negedge rst_n)
    begin
        if (!rst_n)
        count <= 0;
        else if (count == COUNT -1)
        count <= 0;
        else
        count <= count +1;
    end
endmodule