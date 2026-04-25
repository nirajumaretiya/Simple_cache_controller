module tb_main_memory;

reg clk;
reg u_re;
reg u_we;
reg [5:0] u_addr;
reg [31:0] u_din;
wire u_ready;
wire [31:0] u_dout;

main_memory uut (
    .clk(clk),
    .u_re(u_re),
    .u_we(u_we),
    .u_addr(u_addr),
    .u_din(u_din),
    .u_ready(u_ready),
    .u_dout(u_dout)
);

always #5 clk = ~clk;

initial begin
    $dumpfile("main_memory.vcd");
    $dumpvars(0, tb_main_memory);

    clk = 0;
    u_re = 0;
    u_we = 0;
    u_addr = 0;
    u_din = 0;

    #10;
    u_re = 1;
    u_we = 0;
    u_addr = 6'd5;

    #10;
    u_we = 1;
    u_din = 32'hA5A5A5A5;
    u_addr = 6'd10;

    #10;
    u_we = 0;
    u_addr = 6'd10;

    #20;
    u_re = 0;

    #20;
    $finish;
end

endmodule
