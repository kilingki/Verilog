module MEM_WB(
	clk, rst, 
	Control, 
	DRdata, ALUrst, 
	RegDstOut, 
	
	control, 
	dRdata, aLUrst, 
	regDstOut); 

input clk, rst;
input [0:1] Control; //RegWrite, MemToReg
input [31:0] DRdata, ALUrst;
input [4:0] RegDstOut;

output reg [0:1] control;
output reg [4:0] regDstOut;
output reg [31:0] dRdata, aLUrst;

always @ (posedge clk) begin
	if (rst) begin
		control <= 2'b00;
		dRdata <= 0;
		aLUrst <= 0;
		regDstOut <= 0;
	end
	else begin
		control <= Control;
		dRdata <= DRdata;
		aLUrst <= ALUrst;
		regDstOut <= RegDstOut;
	end
end

endmodule
