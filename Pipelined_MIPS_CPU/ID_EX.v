module ID_EX(
	clk, rst, 
	Control, 
	SignExtOut, 
	Rs, Rt, Rd, 
	Rdata1, Rdata2, 
	
	control, 
	signExtOut, rdata1, rdata2, 
	rs, rt, rd);

input clk, rst;
input [0:7]Control;//0:RegDst, 1:RegWrite, 2:ALUSrc, 3,4:ALUOp[1:0], 5:MemWrite, 6:MemRead, 7:MemToReg
input [31:0]SignExtOut, Rdata1, Rdata2;
input [4:0] Rs, Rt, Rd;

output reg [0:7] control;
output reg [31:0] signExtOut, rdata1, rdata2;
output reg [4:0] rs, rt, rd;

always @ (posedge clk) begin
	if(rst) begin
		signExtOut <= {32{1'b0}};
		control <= 8'b00000000; //nop
		rdata1 <= {32{1'b0}};
		rdata2 <= {32{1'b0}};
		rs <= 5'b00000;
		rt <= 5'b00000;
		rd <= 5'b00000;
	end
	else begin
		signExtOut <= SignExtOut;
		control <= Control;
		rdata1 <= Rdata1;
		rdata2 <= Rdata2;
		rs <= Rs;
		rt <= Rt;
		rd <= Rd;
	end
end

endmodule
