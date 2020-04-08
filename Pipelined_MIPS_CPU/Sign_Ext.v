module Sign_Ext(
	in, 
	
	out);

input [15:0]in;

output reg[31:0] out;

always @(*) begin
	if(in[15] == 0) begin
		out[31:16] <= 0;
		out[15:0] <= in[15:0];
	end
	else begin
		out[31:0] <= {{16{1'b1}},in[15:0]}; 
	end
end

endmodule 
