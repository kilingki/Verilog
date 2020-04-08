module Sign_Ext(in, out);
input [15:0]in;
output wire[31:0] out;

reg[31:0]_out;


always @(*) begin
if(in[15] == 0) begin
 _out[31:16] = 0;
 _out[15:0] = in[15:0];
end
else begin
 _out[31:0] = {{16{1'b1}},in[15:0]}; 
end
end

assign out = _out;

endmodule 