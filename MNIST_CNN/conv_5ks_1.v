module conv_5ks_1(
	clk, rst, in_data,
	
	conv_out_1, conv_out_2, conv_out_3,
	valid_out_2
);

input clk, rst;
input [7:0] in_data;

wire [7:0] out_data_0, out_data_1, out_data_2, out_data_3, out_data_4,
	out_data_5, out_data_6, out_data_7, out_data_8, out_data_9,
	out_data_10, out_data_11, out_data_12, out_data_13, out_data_14,
	out_data_15, out_data_16, out_data_17, out_data_18, out_data_19,
	out_data_20, out_data_21, out_data_22, out_data_23, out_data_24;
	
wire valid_out_1;
 
output [11:0] conv_out_1, conv_out_2, conv_out_3;

output valid_out_2;

conv_buf_5ks #(.WIDTH(28), .HEIGHT(28), .DATA_BIT(8)) 
conv_buf_5ks(
	clk, rst,
	in_data,
	
	out_data_0, out_data_1, out_data_2, out_data_3, out_data_4,
	out_data_5, out_data_6, out_data_7, out_data_8, out_data_9,
	out_data_10, out_data_11, out_data_12, out_data_13, out_data_14,
	out_data_15, out_data_16, out_data_17, out_data_18, out_data_19,
	out_data_20, out_data_21, out_data_22, out_data_23, out_data_24,
	
	valid_out_1
);

conv_calc_5ks conv_calc_5ks(
	valid_out_1,
	
	out_data_0, out_data_1, out_data_2, out_data_3, out_data_4,
	out_data_5, out_data_6, out_data_7, out_data_8, out_data_9,
	out_data_10, out_data_11, out_data_12, out_data_13, out_data_14,
	out_data_15, out_data_16, out_data_17, out_data_18, out_data_19,
	out_data_20, out_data_21, out_data_22, out_data_23, out_data_24,

	conv_out_1, conv_out_2, conv_out_3,
	valid_out_2
);

endmodule
