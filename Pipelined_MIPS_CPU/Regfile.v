module Regfile(
	clk, rst,
	Rreg1, Rreg2, Wreg, 
	Wdata, 
	RegWrite, 
	
	Rdata1, Rdata2);

input clk, rst;
input [4:0] Rreg1, Rreg2, Wreg;
input [31:0] Wdata;
input RegWrite;

output reg [31:0] Rdata1, Rdata2;

reg [31:0] rf [0:31];

always @(*) begin //Write
	if(RegWrite == 1 && Wreg != 5'd0)
		rf[Wreg] <= Wdata;
end

always @(*) begin // Read reg1
	if (Rreg1 == 5'd0)
		Rdata1 <= 32'd0;
	else if ((Rreg1 == Wreg) && RegWrite)
		Rdata1 <= Wdata;
	else
		Rdata1 <= rf[Rreg1];
end

always @(*) begin // Read reg2
	if(Rreg2 == 5'd0)
		Rdata2 <= 32'd0;
	else if((Rreg2 == Wreg) && RegWrite)
		Rdata2 <= Wdata;
	else
		Rdata2 <= rf[Rreg2];
end

always @ (posedge clk) begin
	if(rst) begin
		rf[16] <= 0;
		rf[17] <= 0;
	end
end

endmodule

