`timescale 1ns/1ns
module Pipelined_MIPS();
reg clk, rst;

wire Equal, IF_Flush, PCWrite, IDWrite, SelControl;
wire [31:0] addr, naddr, Rdata1, Rdata2, EXRdata1, EXRdata2, MEMRdata2, DRdata, WBDRdata;
wire [31:0] pc_4, PC_4, instr, Instr, ALUin1, ALUSrcin, ALUin2, ALUrst, MEMALUrst, WBALUrst;
wire [31:0] Imm, IMM, BEQ, Jump, JUMP, _SignExtOut, WBWdata, EqIn1, EqIn2;
wire [0:7] Control, ControlOut, EXControl; //MUXout => 0:RegDst, 1:RegWrite, 2:ALUSrc, 3,4:ALUOp[1:0], 5:MemWrite, 6:MemRead, 7:MemToReg
wire [0:3] MEMControl; // 0:MemWrite, 1:MemRead, 2:RegWrite, 3:MemToReg
wire [0:1] WBControl; // 0:RegWrite, 1:MemToReg
wire [4:0] EXRs, EXRt, EXRd, RegDstOut, MEMRd, WBRd;
wire [3:0] ALUctl;
wire [1:0] Fwd1, Fwd2, BEQFwd1, BEQFwd2, SelPC; //(8:Branch, 9:JToPC) => SelPC[1:0]

PC PC(
	clk, rst, 
	PCWrite, 
	naddr, 
	
	addr);
	
InstrMmr InstrMmr(
	addr,
	
	instr);

IF_ID IF_ID(
	clk, rst, 
	instr, 
	IDWrite, IF_Flush, 
	pc_4, 
	
	PC_4, Instr);

Regfile Regfile(
	clk, rst, 
	Instr[25:21], Instr[20:16], WBRd, 
	WBWdata, 
	WBControl[0], 
	
	Rdata1, Rdata2);

BEQ_Fwd BEQ_Fwd(
	clk, rst, 
	Control, 
	Instr[25:21], Instr[20:16], EXRd, MEMRd, 
	
	BEQFwd1, BEQFwd2);
	
_3to1_MUX BEQ1(
	BEQFwd1, 
	Rdata1, ALUrst, MEMALUrst, 
	
	EqIn1);
	
_3to1_MUX BEQ2(
	BEQFwd2, 
	Rdata2, ALUrst, MEMALUrst, 
	
	EqIn2);

Equal_test Equal_test(
	clk, rst, 
	EqIn1, EqIn2, 
	
	Equal);

Control control(
	clk, rst, 
	Equal, 
	Instr[31:26], 
	
	Control, 
	IF_Flush, 
	SelPC);

Sign_Ext se1(
	Instr[15:0], 
	
	Imm);
	
SL2 sl21(
	Imm, 
	
	IMM);

SL2 sl22(
	{6'b0,Instr[25:0]},
	
	Jump);

Hazard Hazard(
	clk, rst, 
	Instr, 
	EXControl[6], 
	EXRs, EXRt, Instr[25:21], Instr[20:16], 
	
	PCWrite, IDWrite, SelControl);

ID_EX ID_EX(
	clk, rst, 
	ControlOut, 
	Imm, 
	Instr[25:21], Instr[20:16], Instr[15:11], 
	Rdata1, Rdata2, 
	
	EXControl, 
	_SignExtOut, EXRdata1, EXRdata2, 
	EXRs, EXRt, EXRd);

_3to1_MUX Naddr(
	SelPC, 
	pc_4, BEQ, JUMP, 
	
	naddr); // SelPC = 00:PC+4, 01:BEQ, 10:JUMP
// address prediction complete

Forwarding Forwarding(
	clk, rst, 
	EXRs, EXRt, MEMRd, WBRd, 
	EXControl, 
	MEMControl[2:3], WBControl[0], 
	
	Fwd1, Fwd2);

_3to1_MUX FWD1(
	Fwd1, 
	EXRdata1, WBWdata, MEMALUrst, 
	
	ALUin1);

_3to1_MUX FWD2(
	Fwd2, 
	EXRdata2, WBWdata, MEMALUrst, 
	
	ALUSrcin); 

ALU_Control ALU_Control(
	EXControl, 
	_SignExtOut[5:0], 
	
	ALUctl);

ALU ALU(
	ALUctl, 
	ALUin1, ALUin2, 
	
	ALUrst);

EX_MEM EX_MEM(
	clk, rst, 
	{EXControl[5:6],EXControl[1],EXControl[7]}, ALUrst, ALUSrcin, 
	RegDstOut, 
	
	MEMControl, 
	MEMALUrst, MEMRdata2, 
	MEMRd);
//MemWrite,MemRead,RegWrite,MemToReg;

DataMmr DataMmr(
	MEMALUrst, MEMALUrst, MEMRdata2, 
	MEMControl[0], MEMControl[1], 
	
	DRdata);

MEM_WB MEM_WB(
	clk, rst, 
	{MEMControl[2],MEMControl[3]}, 
	DRdata, MEMALUrst, 
	MEMRd, 
	
	WBControl, 
	WBDRdata, WBALUrst, 
	WBRd); //RegWrite, MemToReg

assign pc_4 = addr + 32'd4;
assign BEQ = PC_4 + IMM;
assign JUMP = {PC_4[31:28],Jump[27:0]};
assign ControlOut = (SelControl == 0) ? 8'b00000000 : Control[0:7]; // nop or normal
assign RegDstOut = (EXControl[0] == 0) ? EXRt : EXRd;
assign ALUin2 = (EXControl[2] == 0) ? ALUSrcin : _SignExtOut;
assign WBWdata = (WBControl[1] == 0)? WBALUrst : WBDRdata;

always #5 clk = ~clk;

initial begin
	clk <= 0;
	rst <= 0;
#3 	
	rst <= 1;
#3 	
	rst <= 0;
end
endmodule
