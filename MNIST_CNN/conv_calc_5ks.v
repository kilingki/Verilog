module conv_calc_5ks(
	valid_in,
	
	out_data_0, out_data_1, out_data_2, out_data_3, out_data_4,
	out_data_5, out_data_6, out_data_7, out_data_8, out_data_9,
	out_data_10, out_data_11, out_data_12, out_data_13, out_data_14,
	out_data_15, out_data_16, out_data_17, out_data_18, out_data_19,
	out_data_20, out_data_21, out_data_22, out_data_23, out_data_24,

	conv_out_1, conv_out_2, conv_out_3,
	valid_out
);

input valid_in;

input [7:0] out_data_0, out_data_1, out_data_2, out_data_3, out_data_4,
			out_data_5, out_data_6, out_data_7, out_data_8, out_data_9,
			out_data_10, out_data_11, out_data_12, out_data_13, out_data_14,
			out_data_15, out_data_16, out_data_17, out_data_18, out_data_19,
			out_data_20, out_data_21, out_data_22, out_data_23, out_data_24;

// calc_out / 256 = conv_out
output signed [11:0] conv_out_1;
output signed [11:0] conv_out_2;
output signed [11:0] conv_out_3;

output valid_out;

wire signed [19:0] calc_out_1; // 2^18
wire signed [19:0] calc_out_2; // 2^18
wire signed [19:0] calc_out_3; // 2^18

wire signed [8:0] exp_data [0:24];
wire signed [11:0] exp_bias [0:2];

reg signed [7:0] weight_1 [0:24];
reg signed [7:0] weight_2 [0:24];
reg signed [7:0] weight_3 [0:24];
reg signed [7:0] bias [0:2];

initial begin
	$readmemh("conv1_weight_1.txt", weight_1);
	$readmemh("conv1_weight_2.txt", weight_2);
	$readmemh("conv1_weight_3.txt", weight_3);
	$readmemh("conv1_bias.txt", bias);
end

// Unsigned to Signed
assign exp_data[0] = {1'd0, out_data_0};
assign exp_data[1] = {1'd0, out_data_1};
assign exp_data[2] = {1'd0, out_data_2};
assign exp_data[3] = {1'd0, out_data_3};
assign exp_data[4] = {1'd0, out_data_4};
assign exp_data[5] = {1'd0, out_data_5};
assign exp_data[6] = {1'd0, out_data_6};
assign exp_data[7] = {1'd0, out_data_7};
assign exp_data[8] = {1'd0, out_data_8};
assign exp_data[9] = {1'd0, out_data_9};
assign exp_data[10] = {1'd0, out_data_10};
assign exp_data[11] = {1'd0, out_data_11};
assign exp_data[12] = {1'd0, out_data_12};
assign exp_data[13] = {1'd0, out_data_13};
assign exp_data[14] = {1'd0, out_data_14};
assign exp_data[15] = {1'd0, out_data_15};
assign exp_data[16] = {1'd0, out_data_16};
assign exp_data[17] = {1'd0, out_data_17};
assign exp_data[18] = {1'd0, out_data_18};
assign exp_data[19] = {1'd0, out_data_19};
assign exp_data[20] = {1'd0, out_data_20};
assign exp_data[21] = {1'd0, out_data_21};
assign exp_data[22] = {1'd0, out_data_22};
assign exp_data[23] = {1'd0, out_data_23};
assign exp_data[24] = {1'd0, out_data_24};

assign exp_bias[0] = (bias[0][7] == 1) ? {4'b1111, bias[0]} : {4'd0, bias[0]};
assign exp_bias[1] = (bias[1][7] == 1) ? {4'b1111, bias[1]} : {4'd0, bias[1]};
assign exp_bias[2] = (bias[2][7] == 1) ? {4'b1111, bias[2]} : {4'd0, bias[2]};

assign calc_out_1 = exp_data[0]*weight_1[0] + exp_data[1]*weight_1[1] + exp_data[2]*weight_1[2] + exp_data[3]*weight_1[3] + exp_data[4]*weight_1[4] +
					exp_data[5]*weight_1[5] + exp_data[6]*weight_1[6] + exp_data[7]*weight_1[7] + exp_data[8]*weight_1[8] + exp_data[9]*weight_1[9] +
					exp_data[10]*weight_1[10] + exp_data[11]*weight_1[11] + exp_data[12]*weight_1[12] + exp_data[13]*weight_1[13] + exp_data[14]*weight_1[14] +
					exp_data[15]*weight_1[15] + exp_data[16]*weight_1[16] + exp_data[17]*weight_1[17] + exp_data[18]*weight_1[18] + exp_data[19]*weight_1[19] +
					exp_data[20]*weight_1[20] + exp_data[21]*weight_1[21] +exp_data[22]*weight_1[22] +exp_data[23]*weight_1[23] +exp_data[24]*weight_1[24];

assign calc_out_2 = exp_data[0]*weight_2[0] + exp_data[1]*weight_2[1] + exp_data[2]*weight_2[2] + exp_data[3]*weight_2[3] + exp_data[4]*weight_2[4] + 
					exp_data[5]*weight_2[5] + exp_data[6]*weight_2[6] + exp_data[7]*weight_2[7] + exp_data[8]*weight_2[8] + exp_data[9]*weight_2[9] + 
					exp_data[10]*weight_2[10] + exp_data[11]*weight_2[11] + exp_data[12]*weight_2[12] + exp_data[13]*weight_2[13] + exp_data[14]*weight_2[14] + 
					exp_data[15]*weight_2[15] + exp_data[16]*weight_2[16] + exp_data[17]*weight_2[17] + exp_data[18]*weight_2[18] + exp_data[19]*weight_2[19] + 
					exp_data[20]*weight_2[20] + exp_data[21]*weight_2[21] + exp_data[22]*weight_2[22] + exp_data[23]*weight_2[23] + exp_data[24]*weight_2[24];
				
assign calc_out_3 = exp_data[0]*weight_3[0] + exp_data[1]*weight_3[1] + exp_data[2]*weight_3[2] + exp_data[3]*weight_3[3] + exp_data[4]*weight_3[4] + 
					exp_data[5]*weight_3[5] + exp_data[6]*weight_3[6] + exp_data[7]*weight_3[7] + exp_data[8]*weight_3[8] + exp_data[9]*weight_3[9] + 
					exp_data[10]*weight_3[10] + exp_data[11]*weight_3[11] + exp_data[12]*weight_3[12] + exp_data[13]*weight_3[13] + exp_data[14]*weight_3[14] + 
					exp_data[15]*weight_3[15] + exp_data[16]*weight_3[16] + exp_data[17]*weight_3[17] + exp_data[18]*weight_3[18] + exp_data[19]*weight_3[19] + 
					exp_data[20]*weight_3[20] + exp_data[21]*weight_3[21] + exp_data[22]*weight_3[22] + exp_data[23]*weight_3[23] + exp_data[24]*weight_3[24];


assign conv_out_1 = calc_out_1[19:8] + exp_bias[0]; // 12 bits
assign conv_out_2 = calc_out_2[19:8] + exp_bias[1];
assign conv_out_3 = calc_out_3[19:8] + exp_bias[2];

assign valid_out = valid_in;

endmodule