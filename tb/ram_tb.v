`timescale 1ns/1ps

module tb;

parameter ADDR_WIDTH = 6;
parameter DATA_WIDTH = 8;

reg clk;
reg [ADDR_WIDTH-1:0] addr;
reg write_e;
reg [DATA_WIDTH-1:0] din;
wire [DATA_WIDTH-1:0] dout;

ram #(ADDR_WIDTH, DATA_WIDTH) dut (
    .clk(clk),
    .addr(addr),
    .write_e(write_e),
    .din(din),
    .dout(dout)
);

always #5 clk = ~clk;

integer i;

initial begin
    $dumpfile("ram.vcd");
    $dumpvars(0, tb);

    clk = 0;
    addr = 0;
    write_e = 0;
    din = 0;

    #10;
    for(i = 0; i < 10; i = i + 1) begin
    @(negedge clk);
    write_e = 1;
    addr = i;
    din = i + 8'hA0;
    end

    @(negedge clk);
    write_e = 0;

    for(i = 0; i < 10; i = i + 1) begin
        @(posedge clk);
        addr = i;
        @(posedge clk);
        if(dout !== (i + 8'hA0)) begin
            $display("FAIL addr=%0d dout=%h expected=%h", i, dout, (i + 8'hA0));
        end else begin
            $display("PASS addr=%0d dout=%h", i, dout);
        end
    end

    #20;
    $finish;
end

endmodule