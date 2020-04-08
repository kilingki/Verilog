`timescale 1ns/1ns
module tb_mips_cpu();

reg clk, rst;

mips_cpu mips_cpu(
	clk, rst
);

always #5 clk = ~clk;

initial begin
	clk <= 0;
	rst <= 0;
#3 	
	rst <= 1;
#3 	
	rst <= 0;
end
endmodule