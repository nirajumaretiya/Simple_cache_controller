module ram
#(parameter ADDR_WIDTH = 6,
parameter DATA_WIDTH=8
)
(
    input clk,
    input [ADDR_WIDTH-1:0] addr,
    input write_e,
    input [DATA_WIDTH-1:0] din,
    output [DATA_WIDTH-1:0] dout
);

reg [ADDR_WIDTH-1:0] addr_reg;
reg [DATA_WIDTH-1:0] ram_init [2**ADDR_WIDTH-1:0];
assign dout=ram_init[addr_reg];

integer i;
initial begin
    for(i=0;i<2**ADDR_WIDTH;i=i+1) 
    ram_init[i]<={DATA_WIDTH{1'b0}};
end

always @(posedge clk) begin
    if(write_e)
    ram_init[addr]<=din;
    addr_reg<=addr;    
end
endmodule
