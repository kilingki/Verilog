module Control(instr, Control);

input [5:0]instr;
output reg [0:9] Control; //0:RegDst, 1:RegWrite, 2:ALUSrc, 3,4:ALUOp[1:0], 5:MemWrite, 6:MemRead, 7:MemToReg, 8:Branch, 9:JToPC

always @(*) begin
if(instr[5:0] == 6'b000000) //R-type
 Control <= 10'b1101000000;
else if(instr[5:0] == 6'b000010) //jump
 Control <= 10'b0011100001;
else if(instr[5:0] == 6'b000100) //beq
 Control <= 10'b0000100010;
else if(instr[5:0] == 6'b001000) //addi
 Control <= 10'b0110000000;
else if(instr[5:0] == 6'b100011) //lw
 Control <= 10'b0110001100;
else if(instr[5:0] == 6'b101011) //sw
 Control <= 10'b0010010000;
end

endmodule
