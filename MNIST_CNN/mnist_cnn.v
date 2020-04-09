module mnist_cnn(
	clk, rst, in_data,
	
	decision, valid_out
);

input clk, rst;
input [7:0] in_data;

output [3:0] decision;
output valid_out;

wire signed [11:0] conv_out_1, conv_out_2, conv_out_3;
wire signed [11:0] max_value_1, max_value_2, max_value_3;
wire signed [11:0] conv2_out_1, conv2_out_2, conv2_out_3;
wire signed [11:0] max_value2_1, max_value2_2, max_value2_3;
wire signed [11:0] fc_out_data;

wire valid_out_1, valid_out_2, valid_out_3, valid_out_4, valid_out_5;

conv_5ks_1 conv_5ks_1(
	clk, rst, in_data,
	
	conv_out_1, conv_out_2, conv_out_3,
	valid_out_1
);

mxp_relu #(.CONV_BIT(12), .HALF_WIDTH(12), .HALF_HEIGHT(12), .HALF_WIDTH_BIT(4)) 
mxp_relu_1(
    clk, rst,
    valid_out_1,
    conv_out_1, conv_out_2, conv_out_3,
	
    max_value_1, max_value_2, max_value_3,
    valid_out_2
);

conv_5ks_2 conv_5ks_2(
	clk, rst, valid_out_2,
	max_value_1, max_value_2, max_value_3,
	
	conv2_out_1, conv2_out_2, conv2_out_3,
	valid_out_3
);

mxp_relu #(.CONV_BIT(12), .HALF_WIDTH(4), .HALF_HEIGHT(4), .HALF_WIDTH_BIT(3)) 
mxp_relu_2(
    clk, rst,
    valid_out_3,
    conv2_out_1, conv2_out_2, conv2_out_3,
	
    max_value2_1, max_value2_2, max_value2_3,
    valid_out_4
);

fc_layer #(.NUM_INPUT_DATA(48), .NUM_OUTPUT_DATA(10))
fc_layer(
    clk, rst, valid_out_4,
    max_value2_1,
    max_value2_2,
    max_value2_3,

    valid_out_5,
    fc_out_data
);

comparator #(.INPUT_BITS(12), .NUM_CLASS(10))
comparator(
    clk, rst,
    valid_out_5,
    fc_out_data,
			   
    decision,
	valid_out
);  

endmodule
