`timescale 1ns/1ps

module tb;

reg clk;
reg rst_n;
wire [3:0] count;

counter dut(
    .clk(clk),
    .rst_n(rst_n),
    .count(count)
);

always #5 clk = ~clk;

initial begin
    clk = 0;
    rst_n = 0;

    #20 rst_n = 1;

    #100;
    $finish;
end

initial begin
    $dumpfile("wave.vcd");
    $dumpvars(0,tb);
end

initial begin
    $monitor("time=%0t rst_n=%b count=%d",
             $time,rst_n,count);
end

endmodule