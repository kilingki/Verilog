module Control(
	clk, rst,
	Equal, 
	instr, 
	
	Control, 
	iF_Flush, 
	selPC);

input clk, rst;
input Equal; //Rdata1 == Rdata2;
input [5:0]instr;

output reg iF_Flush;
output reg [1:0] selPC; //8:Branch, 9:JToPC => 00:PC+4, 01:BEQ, 10:JUMP
output reg [0:7] Control; //0:RegDst, 1:RegWrite, 2:ALUSrc, 3,4:ALUOp[1:0], 5:MemWrite, 6:MemRead, 7:MemToReg 

always @(*) begin
	if(instr[5:0] == 6'b000000) begin //R-type
		Control <= 8'b11010000;
		selPC <= 2'b00;
		iF_Flush <= 0;
	end
	else if(instr[5:0] == 6'b000010) begin //jump
		Control <= 8'b00111000;
		iF_Flush <= 1;
		selPC <= 2'b10;
	end
	else if(instr[5:0] == 6'b000100) begin //beq
		Control <= 8'b00001000;
		if(Equal == 1) begin
			iF_Flush <= 1;
		selPC <= 2'b01;
	end
	else begin
		iF_Flush <= 0;
		selPC <= 2'b00;
	end
	end
	else if(instr[5:0] == 6'b001000) begin //addi
		Control <= 8'b01100000;
		selPC <= 2'b00;
		iF_Flush <= 0;
	end
	else if(instr[5:0] == 6'b100011) begin //lw
		Control <= 8'b01100011;
		selPC <= 2'b00;
		iF_Flush <= 0;
	end
	else if(instr[5:0] == 6'b101011) begin //sw
		Control <= 8'b00100100;
		selPC <= 2'b00;
		iF_Flush <= 0;
	end
end

always @ (posedge clk) begin
	if(rst) begin
		iF_Flush <= 0;
		selPC <= 2'b00;
	end
end

endmodule
