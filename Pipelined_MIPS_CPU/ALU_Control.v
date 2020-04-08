module ALU_Control(
	EXControl, 
	instr, 
	
	ALUctl); // ALUOp == EXControl[3:4]

input [0:7]EXControl;
input [5:0]instr;

output reg [3:0]ALUctl;

always @(*) begin
	if(EXControl[3:4] == 2'b10) begin
		case(instr)
		6'b011000 : ALUctl <= 4'b1000; //mult
		6'b100000 : ALUctl <= 4'b0010; //add
		6'b100010 : ALUctl <= 4'b0110; //sub
		6'b100100 : ALUctl <= 4'b0000; //and
		6'b100101 : ALUctl <= 4'b0001; //or
		6'b100111 : ALUctl <= 4'b1100; //nor
		6'b101010 : ALUctl <= 4'b0111; //slt
		6'b100110 : ALUctl <= 4'b1111; //xor
		endcase
	end
	else if(EXControl[3:4] == 2'b01)
		ALUctl <= 4'b0011; //beq
	else if(EXControl[3:4] == 2'b00) begin
		ALUctl <= 4'b0010; //addi,lw,sw
	if(EXControl == 8'b00000000)
		ALUctl <= 4'b0011; //nop
	end
end
endmodule 