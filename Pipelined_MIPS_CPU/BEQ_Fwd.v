module BEQ_Fwd(
	clk, rst,
	Control, 
	IDRs, IDRt, EXRd, MEMRd, 
	
	BEQFwd1, BEQFwd2);

input clk, rst;
input [0:7]Control;
input [4:0]IDRs, IDRt, EXRd, MEMRd;

output reg [1:0] BEQFwd1, BEQFwd2;

always @ (*) begin
	if(Control == 8'b00001000 && IDRs != 0) begin // BEQFwd1
		if(IDRs == EXRd) //ALUrst:01
			BEQFwd1 <= 2'b01;
		else if(IDRs == MEMRd) // MEMALUrst:10
			BEQFwd1 <= 2'b10;
		end
	else 
		BEQFwd1 <= 2'b00;
end

always @ (*) begin
	if(Control == 8'b00001000 && IDRt != 0) begin // BEQFwd2
		if(IDRt == EXRd) //ALUrst:01
			BEQFwd2 <= 2'b01;
	else if(IDRt == MEMRd) // MEMALUrst:10
		BEQFwd2 <= 2'b10;
	end
	else 
		BEQFwd2 <= 2'b00;
end

always @ (posedge clk) begin
	if(rst) begin
		BEQFwd1 <= 2'b00;
		BEQFwd2 <= 2'b00;
	end
end

endmodule
