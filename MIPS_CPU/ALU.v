module ALU(ALUctl, in1, in2, out, zero);
input [3:0] ALUctl;
input [31:0] in1; 
input [31:0] in2;

output reg[31:0] out;
output wire zero;

reg _zero;

assign add = in1 + in2;
assign sub = in1 - in2;


always @(*) begin
case (ALUctl)
 4'b0010 : begin
  out <= in1 + in2; //add,lw,sw,addi
 if((out[31] == 1 && (in1 > 0 && in2 > 0)) || (out[31] == 0 && (in1 < 0 && in2 < 0)))
  $display ("overflow occurred (add)");
 end

 4'b0000 : out <= in1 & in2; //and
 4'b1000 : out <= in1 * in2; //mult
 4'b1100 : out <= ~(in1 | in2); //nor
 4'b0001 : out <= in1 | in2; //or
 4'b1111 : out <= in1 ^ in2; //xor 

 4'b0111 : begin
  if(in1 < in2)
   out <= 1;//slt
 end

 4'b0110 : begin 
  out <= in1 - in2; // sub
  if((out[31] == 1 && (in1 > 0 && in2 < 0)) || (out[31] == 0 && (in1 < 0 && in2 > 0)))
    $display ("overflow occurred (sub)");
   if(out == {32{1'b0}})
    _zero <= 1; // beq
   else begin
    _zero <= 0;
    
   end
  end

 default : out <= 0; 
endcase

end

initial begin
_zero = 0;
end

assign zero = _zero;

endmodule
