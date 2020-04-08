module tb_mnist_cnn();

reg clk, rst;
reg state; // 0 : Pixel_Input / 1: No_Input
reg [7:0] img_100 [0 : 78399];
reg [9:0] pixel_count; // 784
reg [9:0] img_count; // 100
reg [9:0] img_index; // 100
reg [7:0] pixel;

wire [3:0] decision;
wire valid_out;

mnist_cnn mnist_cnn(
	clk, rst, pixel,
	
	decision, valid_out
);

always #5 clk = ~clk;

always @ (posedge clk) begin
	if(rst) begin
		rst <= 0;
	end
	else begin
		// Result Out
		if(valid_out == 1) begin
			state <= 0;
			rst <= 1;
			img_index <= img_index + 1;
		end
		
		// Pixel Input
		if(state == 0) begin
			pixel <= img_100[img_count*784 + pixel_count];
			pixel_count <= pixel_count + 1;
			
			// Image Count
			if(pixel_count == 10'd784) begin
				img_count <= img_count + 1;
				if (img_count == 10'd100)
					$stop;
				pixel_count <= 0;
				state <= 1; // Stop Input
			end
			
		end
	end
end

initial begin
	$readmemh("testset.txt", img_100);
	pixel_count <= 0;
	img_count <= 0;
	img_index <= -1;
	state <= 0;
	clk <= 0;
	rst <= 0;
#3
	rst <= 1;
#3
	rst <= 0;
	
end
endmodule