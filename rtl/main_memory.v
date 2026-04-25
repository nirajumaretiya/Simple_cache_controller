module main_memory(
	input clk,
	input u_re,
	input u_we,
	input [5:0] u_addr,
	input [31:0] u_din,
	output reg u_ready,
	output [31:0] u_dout
);

reg [31:0] mem[2**6-1:0];
reg [5:0] addr_reg;
integer i;
initial begin
	for(i=0;i<2**6;i=i+1) begin
		mem[i][7:0]=4*i;
		mem[i][15:8]=4*i+1;
		mem[i][23:16]=4*i+2;
		mem[i][31:24]=4*i+3;
	end
end

always@(posedge clk) begin
	if(u_re) begin
		u_ready=1'b1;
		if(u_we) mem[u_addr]=u_din;
	end
	else u_ready=1'b0;
	addr_reg<=u_addr;
end
assign u_dout=mem[addr_reg];
endmodule
