module conv2_calc_5ks_1(
	clk, rst, valid_in,
	
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

	conv_out,
	valid_out
);

input clk, rst, valid_in;
input signed [11:0] out_data1_0, out_data1_1, out_data1_2, out_data1_3, out_data1_4,
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

// calc_out / 256 = conv_out
output signed [13:0] conv_out; //14bit
output reg valid_out;

wire signed [19:0] calc_out, calc_out_1, calc_out_2, calc_out_3; // 2^22

reg signed [7:0] weight_1 [0:24];
reg signed [7:0] weight_2 [0:24];
reg signed [7:0] weight_3 [0:24];

initial begin
	$readmemh("conv2_weight_11.txt", weight_1);
	$readmemh("conv2_weight_12.txt", weight_2);
	$readmemh("conv2_weight_13.txt", weight_3);

end

assign calc_out_1 = out_data1_0*weight_1[0] + out_data1_1*weight_1[1] + out_data1_2*weight_1[2] + out_data1_3*weight_1[3] + out_data1_4*weight_1[4] + 
					out_data1_5*weight_1[5] + out_data1_6*weight_1[6] + out_data1_7*weight_1[7] + out_data1_8*weight_1[8] + out_data1_9*weight_1[9] + 
					out_data1_10*weight_1[10] + out_data1_11*weight_1[11] + out_data1_12*weight_1[12] + out_data1_13*weight_1[13] + out_data1_14*weight_1[14] + 
					out_data1_15*weight_1[15] + out_data1_16*weight_1[16] + out_data1_17*weight_1[17] + out_data1_18*weight_1[18] + out_data1_19*weight_1[19] + 
					out_data1_20*weight_1[20] + out_data1_21*weight_1[21] + out_data1_22*weight_1[22] + out_data1_23*weight_1[23] + out_data1_24*weight_1[24];

assign calc_out_2 = out_data2_0*weight_2[0] + out_data2_1*weight_2[1] + out_data2_2*weight_2[2] + out_data2_3*weight_2[3] + out_data2_4*weight_2[4] + 
					out_data2_5*weight_2[5] + out_data2_6*weight_2[6] + out_data2_7*weight_2[7] + out_data2_8*weight_2[8] + out_data2_9*weight_2[9] + 
					out_data2_10*weight_2[10] + out_data2_11*weight_2[11] + out_data2_12*weight_2[12] + out_data2_13*weight_2[13] + out_data2_14*weight_2[14] + 
					out_data2_15*weight_2[15] + out_data2_16*weight_2[16] + out_data2_17*weight_2[17] + out_data2_18*weight_2[18] + out_data2_19*weight_2[19] + 
					out_data2_20*weight_2[20] + out_data2_21*weight_2[21] + out_data2_22*weight_2[22] + out_data2_23*weight_2[23] + out_data2_24*weight_2[24];

assign calc_out_3 = out_data3_0*weight_3[0] + out_data3_1*weight_3[1] + out_data3_2*weight_3[2] + out_data3_3*weight_3[3] + out_data3_4*weight_3[4] + 
					out_data3_5*weight_3[5] + out_data3_6*weight_3[6] + out_data3_7*weight_3[7] + out_data3_8*weight_3[8] + out_data3_9*weight_3[9] + 
					out_data3_10*weight_3[10] + out_data3_11*weight_3[11] + out_data3_12*weight_3[12] + out_data3_13*weight_3[13] + out_data3_14*weight_3[14] + 
					out_data3_15*weight_3[15] + out_data3_16*weight_3[16] + out_data3_17*weight_3[17] + out_data3_18*weight_3[18] + out_data3_19*weight_3[19] + 
					out_data3_20*weight_3[20] + out_data3_21*weight_3[21] + out_data3_22*weight_3[22] + out_data3_23*weight_3[23] + out_data3_24*weight_3[24];

assign calc_out = calc_out_1 + calc_out_2 + calc_out_3;

assign conv_out = calc_out[19:6]; // 14bit

always @ (posedge clk) begin
	if(rst) begin
		valid_out <= 0;
	end
	else begin
		// Toggling Valid Output Signal
		if(valid_in == 1) begin
			if(valid_out == 1)
				valid_out <= 0;
			else
				valid_out <= 1;
		end
	end
end

endmodule