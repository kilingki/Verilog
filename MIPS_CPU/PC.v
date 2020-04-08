module PC(rst,clk,next_addr,curr_addr);

input clk, rst;
input [31:0]next_addr;

output reg[31:0]curr_addr;

always @ (posedge clk) begin
 if(rst)
  curr_addr[31:0] = {32{1'b0}};
 else
  curr_addr[31:0] = next_addr;
end

endmodule 