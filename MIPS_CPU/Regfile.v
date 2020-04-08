module regfile(Rreg1, Rreg2, Wreg, Wdata, RegWrite, Rdata1, Rdata2);

input wire RegWrite;
input wire [4:0] Rreg1, Rreg2, Wreg;
input wire [31:0] Wdata;
output wire [31:0]Rdata1, Rdata2;

reg [31:0]rf[0:31];
reg[31:0] _Rdata1, _Rdata2;

always @(*) begin //Write
if(RegWrite == 1 && Wreg != 5'd0)
 rf[Wreg] <= Wdata;
end

always @(*) begin // Read reg1
 if (Rreg1 == 5'd0)
  _Rdata1 = 32'd0;
 else if ((Rreg1 == Wreg) && RegWrite)
  _Rdata1 = Wdata;
 else
  _Rdata1 = rf[Rreg1];
end

always @(*) begin // Read reg2
 if(Rreg2 == 5'd0)
  _Rdata2 = 32'd0;
 else if((Rreg2 == Wreg) && RegWrite)
  _Rdata2 = Wdata;
 else
  _Rdata2 = rf[Rreg2];
end

assign Rdata1 = _Rdata1;
assign Rdata2 = _Rdata2;

endmodule

