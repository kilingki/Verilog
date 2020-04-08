module DataMmr#(parameter W = 128)(
	Raddr, Waddr, Wdata, 
	MemWrite, MemRead, 
	
	Rdata);

input [31:0]Raddr, Waddr, Wdata;
input MemWrite, MemRead;

output reg [31:0] Rdata;

wire [31:0]Raddr_2, Waddr_2;

assign Raddr_2 = {2'b00,Raddr[31:2]};
assign Waddr_2 = {2'b00,Waddr[31:2]};

reg [31:0] mmr [0 : W - 1];

always @(*) begin
	if(MemWrite == 1 && MemRead == 0)
		mmr[Waddr_2] <= Wdata; 
	else if(MemWrite == 0 && MemRead == 1)
		Rdata <= mmr[Raddr_2];
end

initial begin
	mmr[0] = 1;
	mmr[1] = 0;
	mmr[2] = 0;
	mmr[10] = 32'b01010101_10101010_01010101_10101010;
	mmr[11] = 32'b01110111_10001000_01110111_10001000;
end

endmodule