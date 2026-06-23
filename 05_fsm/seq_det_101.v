/*module seq_DET101(
                    input in,
                    input clk,
                    input rst_n,
                    output reg seq_det
);*/

/*typedef enum reg [1:0] {
    S0 = 2'b00,
    S1 = 2'b01,
    S2 = 2'b10,
    S3 = 2'b11
} state_fsm;

state_fsm state, next_state;*/
/*reg [1:0] state, next_state;
always@(posedge clk or negedge rst_n) begin
   if(~rst_n)
   begin
    state <= 2'b00;
    //next_state <=S0;
   end 
   else
   state <= next_state;
end

always@(*) begin
    
    case(state)
    2'b00 : next_state = in? 2'b01:2'b00;
    2'b01 : next_state = in? 2'b01:2'b10;
    2'b10 : next_state = in? 2'b11:2'b00;
    2'b11 : next_state = in? 2'b01:2'b10;
    default : next_state = 2'b00;
endcase

end

always @(*) begin
    if(state == 2'b11)
    seq_det = 1;
    else
    seq_det = 0;
end
endmodule*/


module seq_DET101(
    input  in,
    input  clk,
    input  rst_n,
    output seq_det
);

localparam S0 = 2'b00;
localparam S1 = 2'b01;
localparam S2 = 2'b10;
localparam S3 = 2'b11;

reg [1:0] state, next_state;

always @(posedge clk or negedge rst_n) begin
    if(!rst_n)
        state <= S0;
    else
        state <= next_state;
end

always @(*) begin
    case(state)
        S0: next_state = in ? S1 : S0;
        S1: next_state = in ? S1 : S2;
        S2: next_state = in ? S3 : S0;
        S3: next_state = in ? S1 : S2;
        default: next_state = S0;
    endcase
end

assign seq_det = (state == S3);

endmodule