module DataMmr#(parameter W = 128)
(Raddr, Waddr, Wdata, MemWrite, MemRead, Rdata);

input [31:0]Raddr;
input [31:0]Waddr;
input [31:0]Wdata;

input MemWrite;
input MemRead;

wire [31:0]_Raddr, _Waddr;

assign _Raddr = {2'b00,Raddr[31:2]};
assign _Waddr = {2'b00,Waddr[31:2]};

output reg[31:0]Rdata;

reg [31:0]mmr[0:W-1];

always @(*) begin
if(MemWrite == 1 && MemRead == 0)
 mmr[_Waddr] <= Wdata; 
else if(MemWrite == 0 && MemRead == 1)
 Rdata <= mmr[_Raddr];
end

initial begin
mmr[0] = 1;
mmr[1] = 0;
mmr[2] = 0;
mmr[10] = 32'b01010101_10101010_01010101_10101010;
mmr[11] = 32'b01110111_10001000_01110111_10001000;
end

endmodule
