module Hazard(
	clk, rst,
	Instr, 
	EXMemRead, 
	EXRs, EXRt, IDRs, IDRt, 
	
	PCWrite, IDWrite, SelControl); //lw stall

input clk, rst;
input [31:0]Instr;
input EXMemRead;
input [4:0]EXRs, EXRt, IDRs, IDRt;

output reg PCWrite, IDWrite, SelControl;

always @(*) begin
	if(EXMemRead == 1 && (EXRt == IDRs || EXRt == IDRt)) begin
		PCWrite <= 1;
		IDWrite <= 1;
		SelControl <= 0;
	end
	else if(Instr == 0) begin
		PCWrite <= 0;
		IDWrite <= 0;
		SelControl <= 0;
	end
	else begin
		PCWrite <= 0;
		IDWrite <= 0;
		SelControl <= 1;
	end
end

always @ (posedge clk) begin
	if(rst) begin
		PCWrite <= 0;
		IDWrite <= 0;
		SelControl <= 0;
	end
end

endmodule
