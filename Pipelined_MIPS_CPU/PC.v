module PC(
	clk, rst,
	PCWrite, 
	next_addr, 
	
	curr_addr);

input clk, rst, PCWrite;
input [31:0]next_addr;

output reg[31:0]curr_addr;

always @ (posedge clk) begin
	if(rst)
		curr_addr[31:0] = {32{1'b0}};
	else begin
		if(PCWrite == 0)
			curr_addr <= next_addr;
		else // When Harzard occured
			curr_addr <= curr_addr;
	end
end

endmodule 