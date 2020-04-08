module EX_MEM(
	clk, rst, 
	Control, ALUrst, Rdata2, 
	RegDstOut, 
	
	control, 
	aLUrst, rdata2, 
	regDstOut); 

input clk, rst;
input [0:3] Control; //MemWrite,MemRead,RegWrite,MemToReg;
input [31:0] ALUrst, Rdata2;
input [4:0] RegDstOut;

output reg [0:3] control;
output reg [31:0] aLUrst, rdata2;
output reg [4:0] regDstOut;

always @ (posedge clk) begin
	if(rst) begin
		control <= 4'b0000;
		aLUrst <= 0; 
		rdata2 <= 0; 
		regDstOut <= 0;
	end
	else begin
		control <= Control;
		aLUrst <= ALUrst;  
		rdata2 <= Rdata2; 
		regDstOut <= RegDstOut;
	end
end

endmodule
