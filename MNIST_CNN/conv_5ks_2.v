module conv_5ks_2(
	clk, rst, valid_in,
	max_value_1, max_value_2, max_value_3,
	
	conv2_out_1, conv2_out_2, conv2_out_3,
	valid_out
);

input clk, rst, valid_in;
input [11:0] max_value_1, max_value_2, max_value_3;

output signed [11:0] conv2_out_1, conv2_out_2, conv2_out_3;
output valid_out;

reg signed [7:0] bias [0:2];
wire signed [11:0] exp_bias [0:2];

wire [11:0] out_data1_0, out_data1_1, out_data1_2, out_data1_3, out_data1_4,
			out_data1_5, out_data1_6, out_data1_7, out_data1_8, out_data1_9,
			out_data1_10, out_data1_11, out_data1_12, out_data1_13, out_data1_14,
			out_data1_15, out_data1_16, out_data1_17, out_data1_18, out_data1_19,
			out_data1_20, out_data1_21, out_data1_22, out_data1_23, out_data1_24,
			
			out_data2_0, out_data2_1, out_data2_2, out_data2_3, out_data2_4,
			out_data2_5, out_data2_6, out_data2_7, out_data2_8, out_data2_9,
			out_data2_10, out_data2_11, out_data2_12, out_data2_13, out_data2_14,
			out_data2_15, out_data2_16, out_data2_17, out_data2_18, out_data2_19,
			out_data2_20, out_data2_21, out_data2_22, out_data2_23, out_data2_24,
			
			out_data3_0, out_data3_1, out_data3_2, out_data3_3, out_data3_4,
			out_data3_5, out_data3_6, out_data3_7, out_data3_8, out_data3_9,
			out_data3_10, out_data3_11, out_data3_12, out_data3_13, out_data3_14,
			out_data3_15, out_data3_16, out_data3_17, out_data3_18, out_data3_19,
			out_data3_20, out_data3_21, out_data3_22, out_data3_23, out_data3_24;

wire signed [13:0] conv_out_1, conv_out_2, conv_out_3;

wire valid_out_and, valid_out_1, valid_out_2, valid_out_3,
	 valid_out_conv_1, valid_out_conv_2, valid_out_conv_3;

assign valid_out_and = valid_out_1 & valid_out_2 & valid_out_3;
assign valid_out = valid_out_conv_1 & valid_out_conv_2 & valid_out_conv_3;


conv2_buf_5ks #(.WIDTH(12), .HEIGHT(12), .DATA_BIT(12)) 
conv2_buf_5ks_1(
	clk, rst, valid_in,
	max_value_1,
	
	out_data1_0, out_data1_1, out_data1_2, out_data1_3, out_data1_4,
	out_data1_5, out_data1_6, out_data1_7, out_data1_8, out_data1_9,
	out_data1_10, out_data1_11, out_data1_12, out_data1_13, out_data1_14,
	out_data1_15, out_data1_16, out_data1_17, out_data1_18, out_data1_19,
	out_data1_20, out_data1_21, out_data1_22, out_data1_23, out_data1_24,
	
	valid_out_1
);

conv2_buf_5ks #(.WIDTH(12), .HEIGHT(12), .DATA_BIT(12)) 
conv2_buf_5ks_2(
	clk, rst, valid_in,
	max_value_2,
	
	out_data2_0, out_data2_1, out_data2_2, out_data2_3, out_data2_4,
	out_data2_5, out_data2_6, out_data2_7, out_data2_8, out_data2_9,
	out_data2_10, out_data2_11, out_data2_12, out_data2_13, out_data2_14,
	out_data2_15, out_data2_16, out_data2_17, out_data2_18, out_data2_19,
	out_data2_20, out_data2_21, out_data2_22, out_data2_23, out_data2_24,
	
	valid_out_2
);

conv2_buf_5ks #(.WIDTH(12), .HEIGHT(12), .DATA_BIT(12))  
conv2_buf_5ks_3(
	clk, rst, valid_in,
	max_value_3,
	
	out_data3_0, out_data3_1, out_data3_2, out_data3_3, out_data3_4,
	out_data3_5, out_data3_6, out_data3_7, out_data3_8, out_data3_9,
	out_data3_10, out_data3_11, out_data3_12, out_data3_13, out_data3_14,
	out_data3_15, out_data3_16, out_data3_17, out_data3_18, out_data3_19,
	out_data3_20, out_data3_21, out_data3_22, out_data3_23, out_data3_24,
	
	valid_out_3
);

conv2_calc_5ks_1 conv2_calc_5ks_1(
	clk, rst, valid_out_and,
	
	out_data1_0, out_data1_1, out_data1_2, out_data1_3, out_data1_4,
	out_data1_5, out_data1_6, out_data1_7, out_data1_8, out_data1_9,
	out_data1_10, out_data1_11, out_data1_12, out_data1_13, out_data1_14,
	out_data1_15, out_data1_16, out_data1_17, out_data1_18, out_data1_19,
	out_data1_20, out_data1_21, out_data1_22, out_data1_23, out_data1_24,
	
	out_data2_0, out_data2_1, out_data2_2, out_data2_3, out_data2_4,
	out_data2_5, out_data2_6, out_data2_7, out_data2_8, out_data2_9,
	out_data2_10, out_data2_11, out_data2_12, out_data2_13, out_data2_14,
	out_data2_15, out_data2_16, out_data2_17, out_data2_18, out_data2_19,
	out_data2_20, out_data2_21, out_data2_22, out_data2_23, out_data2_24,
	
	out_data3_0, out_data3_1, out_data3_2, out_data3_3, out_data3_4,
	out_data3_5, out_data3_6, out_data3_7, out_data3_8, out_data3_9,
	out_data3_10, out_data3_11, out_data3_12, out_data3_13, out_data3_14,
	out_data3_15, out_data3_16, out_data3_17, out_data3_18, out_data3_19,
	out_data3_20, out_data3_21, out_data3_22, out_data3_23, out_data3_24,

	conv_out_1,
	valid_out_conv_1
);

conv2_calc_5ks_2 conv2_calc_5ks_2(
	clk, rst, valid_out_and,
	
	out_data1_0, out_data1_1, out_data1_2, out_data1_3, out_data1_4,
	out_data1_5, out_data1_6, out_data1_7, out_data1_8, out_data1_9,
	out_data1_10, out_data1_11, out_data1_12, out_data1_13, out_data1_14,
	out_data1_15, out_data1_16, out_data1_17, out_data1_18, out_data1_19,
	out_data1_20, out_data1_21, out_data1_22, out_data1_23, out_data1_24,
	
	out_data2_0, out_data2_1, out_data2_2, out_data2_3, out_data2_4,
	out_data2_5, out_data2_6, out_data2_7, out_data2_8, out_data2_9,
	out_data2_10, out_data2_11, out_data2_12, out_data2_13, out_data2_14,
	out_data2_15, out_data2_16, out_data2_17, out_data2_18, out_data2_19,
	out_data2_20, out_data2_21, out_data2_22, out_data2_23, out_data2_24,
	
	out_data3_0, out_data3_1, out_data3_2, out_data3_3, out_data3_4,
	out_data3_5, out_data3_6, out_data3_7, out_data3_8, out_data3_9,
	out_data3_10, out_data3_11, out_data3_12, out_data3_13, out_data3_14,
	out_data3_15, out_data3_16, out_data3_17, out_data3_18, out_data3_19,
	out_data3_20, out_data3_21, out_data3_22, out_data3_23, out_data3_24,
	
	conv_out_2,
	valid_out_conv_2
);

conv2_calc_5ks_3 conv2_calc_5ks_3(
	clk, rst, valid_out_and,
	
	out_data1_0, out_data1_1, out_data1_2, out_data1_3, out_data1_4,
	out_data1_5, out_data1_6, out_data1_7, out_data1_8, out_data1_9,
	out_data1_10, out_data1_11, out_data1_12, out_data1_13, out_data1_14,
	out_data1_15, out_data1_16, out_data1_17, out_data1_18, out_data1_19,
	out_data1_20, out_data1_21, out_data1_22, out_data1_23, out_data1_24,
	
	out_data2_0, out_data2_1, out_data2_2, out_data2_3, out_data2_4,
	out_data2_5, out_data2_6, out_data2_7, out_data2_8, out_data2_9,
	out_data2_10, out_data2_11, out_data2_12, out_data2_13, out_data2_14,
	out_data2_15, out_data2_16, out_data2_17, out_data2_18, out_data2_19,
	out_data2_20, out_data2_21, out_data2_22, out_data2_23, out_data2_24,
	
	out_data3_0, out_data3_1, out_data3_2, out_data3_3, out_data3_4,
	out_data3_5, out_data3_6, out_data3_7, out_data3_8, out_data3_9,
	out_data3_10, out_data3_11, out_data3_12, out_data3_13, out_data3_14,
	out_data3_15, out_data3_16, out_data3_17, out_data3_18, out_data3_19,
	out_data3_20, out_data3_21, out_data3_22, out_data3_23, out_data3_24,
	
	conv_out_3,
	valid_out_conv_3
);

initial begin
	$readmemh("conv2_bias.txt", bias);
end

assign exp_bias[0] = (bias[0][7] == 1) ? {4'b1111, bias[0]} : {4'd0, bias[0]};
assign exp_bias[1] = (bias[1][7] == 1) ? {4'b1111, bias[1]} : {4'd0, bias[1]};
assign exp_bias[2] = (bias[2][7] == 1) ? {4'b1111, bias[2]} : {4'd0, bias[2]};

assign conv2_out_1 = conv_out_1[13:1] + exp_bias[0];
assign conv2_out_2 = conv_out_2[13:1] + exp_bias[1];
assign conv2_out_3 = conv_out_3[13:1] + exp_bias[2];

endmodule
