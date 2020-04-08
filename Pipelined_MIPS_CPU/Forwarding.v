module Forwarding(
	clk, rst,
	EXRs, EXRt, MEMRd, WBRd, 
	EXControl, 
	MEMControl, WBRegWrite, 
	
	Fwd1, Fwd2);

input clk, rst;
input [4:0]EXRs, EXRt, MEMRd, WBRd;
input [0:7]EXControl;
input [0:1]MEMControl;// 0:RegWrite, 1:MemToReg
input WBRegWrite; 

output reg [1:0]Fwd1, Fwd2;

always @ (*) begin //SelALUin1
	if(EXControl == 0)
		Fwd1 <= 2'b00;
	else begin
		if(MEMRd != 0 && MEMRd == EXRs) begin //MEMALUrst:10
			if(MEMControl[0] == 1)
				Fwd1 <= 2'b10;
			else 
				Fwd1 <= 2'b00;
		end
	else if(WBRd != 0 && WBRd == EXRs) begin //WBWdata:01
		if(WBRegWrite == 1)
			Fwd1 <= 2'b01;
		else
			Fwd1 <= 2'b00;
	end
	else
		Fwd1 <= 2'b00;
	end
end

always @ (*) begin //SelALUin2
	if(EXControl == 0)
		Fwd2 <= 2'b00;
	else begin
		if(MEMRd != 0 && MEMRd == EXRt) begin //MEMALUrst:10
			if(MEMControl[0] == 1)
				Fwd2 <= 2'b10;
			else 
				Fwd2 <= 2'b00;
		end
		else if(WBRd != 0 && WBRd == EXRt) begin //WBWdata:01
			if(WBRegWrite == 1)
				Fwd2 <= 2'b01;
			else
				Fwd2 <= 2'b00;
		end
		else
			Fwd2 <= 2'b00;
	end
end

always @(posedge clk) begin
	if(rst) begin
		Fwd1 <= 2'b00;
		Fwd2 <= 2'b00;
	end
end

endmodule