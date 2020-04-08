`timescale 1ns/1ns

module MIPS_CPU();
reg clk,rst; 

wire [31:0] addr, instr, jump, jaddr, braddr, naddr;
wire [31:0] ALUSrcout, Extout, ALUrslt, MtoRout, PCSrcout;
wire [31:0] _Rdata1, _Rdata2, _DRdata, PC_4, offsetx4;
wire [0:9] _Control;
wire [4:0] RegDstout;
wire [3:0] ALUctl;
wire _zero, PCSrc;

assign RegDstout = (_Control[0] == 0) ? instr[20:16] : instr[15:11];
assign ALUSrcout = (_Control[2] == 0) ? _Rdata2 : Extout;
assign MtoRout = (_Control[7] == 0) ? ALUrslt : _DRdata;
assign PC_4[31:0] = addr + {32'b00000000_00000000_00000000_00000100}; 
assign jaddr[31:0] = {PC_4[31:28],jump[27:0]};
assign braddr = offsetx4 + PC_4;
assign PCSrc = _zero * _Control[8];
assign PCSrcout = (PCSrc == 0) ? PC_4 : braddr;
assign naddr = (_Control[9] == 0) ? PCSrcout : jaddr;

InstrMmr im(
	addr,
	
	instr);
	
Control Control(
	instr[31:26], 
	
	_Control);

regfile Regfile(

	instr[25:21], 
	instr[20:16], 
	RegDstout, 
	MtoRout, 
	_Control[1], 

	_Rdata1, _Rdata2);
	
Sign_Ext Sign_Extend(
	instr[15:0], 
	
	Extout[31:0]);

ALU_Control ALUControl(
	_Control[3:4], instr[5:0], 
	
	ALUctl);
	
ALU ALU(
	ALUctl, 
	_Rdata1, ALUSrcout, 
	
	ALUrslt, _zero);

DataMmr DataMmr(
	ALUrslt, ALUrslt, _Rdata2, 
	_Control[5], _Control[6], 
	
	_DRdata);

ShiftL2 SL2(
	{{6{1'b0}},instr[25:0]}, 
	
	jump[31:0]);

ShiftL2 SL2_2(
	Extout[31:0], 
	
	offsetx4[31:0]);

PC pc(
	rst, clk, 
	naddr, addr);

always begin
#5 clk = ~clk;
end

initial begin
clk = 0;
rst = 0;
#3 rst = 1;
#3 rst = 0;
end
endmodule