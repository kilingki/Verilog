module Equal_test(
	clk, rst,
	Rdata1, Rdata2, 
	
	Equal);
	
input clk, rst;
input [31:0] Rdata1, Rdata2;

output reg Equal;

always @ (posedge clk) begin
	if(rst) Equal <= 0;
end

always @(*) begin
	if(Rdata1 ==  Rdata2)
		Equal <= 1;
	else
		Equal <= 0;
end

endmodule

