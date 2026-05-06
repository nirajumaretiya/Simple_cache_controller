module low_lru_way_finder(
    input [1:0] curr_lru,
    output reg way_offset_lower_lru_way);
    always @(*) begin
        casex(curr_lru)
        2'bx0: way_offset_lower_lru_way=1'b0;
        2'b01: way_offset_lower_lru_way=1'b1;
        2'b11: way_offset_lower_lru_way=1'bx;
        endcase
    end
endmodule