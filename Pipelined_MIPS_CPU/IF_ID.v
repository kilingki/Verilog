module IF_ID(
	clk, rst, 
	instr, 
	IDWrite, IF_Flush, 
	pc_4, 
	
	PC_4, Instr);

input clk, rst, IDWrite, IF_Flush;
input [0:31] pc_4, instr;

output reg [0:31] PC_4, Instr;

always @ (posedge clk) begin
	if(rst) begin
		PC_4 <= 0;
		Instr <= 0;
	end 
	else begin
		if(IDWrite == 0 && IF_Flush == 0) begin
			PC_4 <= pc_4;
			Instr <= instr;
		end
		else if(IDWrite == 0 && IF_Flush == 1) begin
			PC_4 <= pc_4; 
			Instr <= {32{1'b0}};
		end
		else if(IDWrite == 1 && IF_Flush == 0)
			Instr <= Instr;
	end
end

endmodule 