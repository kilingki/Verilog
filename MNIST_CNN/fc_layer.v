module fc_layer #(parameter NUM_INPUT_DATA = 48, NUM_OUTPUT_DATA = 10)
(
    clk, rst, valid_in,
    in_data_1,
    in_data_2,
    in_data_3,

    valid_out,
    out_data
);

localparam DIVIDED_NUM_INPUT = 16; // 48/3
localparam NUM_INPUT_DATA_BITS = 5; // ceil(log_2(48/3)) + 1

input clk, rst, valid_in;
input signed [11 : 0] in_data_1, in_data_2, in_data_3;

output signed [11:0] out_data;
output reg valid_out;

wire signed [19:0] calc_out; // Calculation Result

reg state; // 0 : Buffer Stacking // 1 : Calculation

reg [NUM_INPUT_DATA_BITS - 1 : 0] buf_count; // Buffer Stacking Count

reg [3:0] out_count; // Output Change (10)

reg signed [13:0] buffer [0 : NUM_INPUT_DATA - 1];

reg signed [7: 0] weight [0 : NUM_INPUT_DATA * NUM_OUTPUT_DATA - 1];
reg signed [7: 0] bias [0 : NUM_OUTPUT_DATA - 1];

wire signed [13:0] data_1, data_2, data_3;

initial begin
    $readmemh("fc_weight.txt", weight);
    $readmemh("fc_bias.txt", bias);
end

assign data_1 = (in_data_1[11] == 1) ? {2'b11, in_data_1} : {2'd0, in_data_1};
assign data_2 = (in_data_2[11] == 1) ? {2'b11, in_data_2} : {2'd0, in_data_2};
assign data_3 = (in_data_3[11] == 1) ? {2'b11, in_data_3} : {2'd0, in_data_3};

always @ (posedge clk) begin
    if(rst) begin
        valid_out <= 0;
		buf_count <= 0;
		out_count <= 0;
        state <= 0;
    end
	else begin
	
		if(valid_out == 1) 
		valid_out <= 0; // Return to Zero
		
		if(valid_in == 1) begin
		
			// Buffer Stacking
			if(state == 0) begin
				buffer[buf_count] <= data_1;
				buffer[DIVIDED_NUM_INPUT + buf_count] <= data_2;
				buffer[DIVIDED_NUM_INPUT * 2 + buf_count] <= data_3;
				
				// Count 16 (48 / 3)
				buf_count <= buf_count + 1;
				if(buf_count == DIVIDED_NUM_INPUT - 1) begin
					buf_count <= 0;
					state <= 1;
					valid_out <= 1;
				end
			end
			
			// Calculation
			else begin
				out_count <= out_count + 1;
				if(out_count == NUM_OUTPUT_DATA - 1) begin
					out_count <= 0;
				end
				valid_out <= 1;
			end

		end
	end	
end

assign calc_out = weight[out_count * NUM_INPUT_DATA] * buffer[0] + weight[out_count * NUM_INPUT_DATA + 1] * buffer[1] + 
				weight[out_count * NUM_INPUT_DATA + 2] * buffer[2] + weight[out_count * NUM_INPUT_DATA + 3] * buffer[3] + 
				weight[out_count * NUM_INPUT_DATA + 4] * buffer[4] + weight[out_count * NUM_INPUT_DATA + 5] * buffer[5] + 
				weight[out_count * NUM_INPUT_DATA + 6] * buffer[6] + weight[out_count * NUM_INPUT_DATA + 7] * buffer[7] + 
				weight[out_count * NUM_INPUT_DATA + 8] * buffer[8] + weight[out_count * NUM_INPUT_DATA + 9] * buffer[9] + 
				weight[out_count * NUM_INPUT_DATA + 10] * buffer[10] + weight[out_count * NUM_INPUT_DATA + 11] * buffer[11] + 
				weight[out_count * NUM_INPUT_DATA + 12] * buffer[12] + weight[out_count * NUM_INPUT_DATA + 13] * buffer[13] + 
				weight[out_count * NUM_INPUT_DATA + 14] * buffer[14] + weight[out_count * NUM_INPUT_DATA + 15] * buffer[15] + 
				weight[out_count * NUM_INPUT_DATA + 16] * buffer[16] + weight[out_count * NUM_INPUT_DATA + 17] * buffer[17] + 
				weight[out_count * NUM_INPUT_DATA + 18] * buffer[18] + weight[out_count * NUM_INPUT_DATA + 19] * buffer[19] + 
				weight[out_count * NUM_INPUT_DATA + 20] * buffer[20] + weight[out_count * NUM_INPUT_DATA + 21] * buffer[21] + 
				weight[out_count * NUM_INPUT_DATA + 22] * buffer[22] + weight[out_count * NUM_INPUT_DATA + 23] * buffer[23] + 
				weight[out_count * NUM_INPUT_DATA + 24] * buffer[24] + weight[out_count * NUM_INPUT_DATA + 25] * buffer[25] + 
				weight[out_count * NUM_INPUT_DATA + 26] * buffer[26] + weight[out_count * NUM_INPUT_DATA + 27] * buffer[27] + 
				weight[out_count * NUM_INPUT_DATA + 28] * buffer[28] + weight[out_count * NUM_INPUT_DATA + 29] * buffer[29] + 
				weight[out_count * NUM_INPUT_DATA + 30] * buffer[30] + weight[out_count * NUM_INPUT_DATA + 31] * buffer[31] + 
				weight[out_count * NUM_INPUT_DATA + 32] * buffer[32] + weight[out_count * NUM_INPUT_DATA + 33] * buffer[33] + 
				weight[out_count * NUM_INPUT_DATA + 34] * buffer[34] + weight[out_count * NUM_INPUT_DATA + 35] * buffer[35] + 
				weight[out_count * NUM_INPUT_DATA + 36] * buffer[36] + weight[out_count * NUM_INPUT_DATA + 37] * buffer[37] + 
				weight[out_count * NUM_INPUT_DATA + 38] * buffer[38] + weight[out_count * NUM_INPUT_DATA + 39] * buffer[39] + 
				weight[out_count * NUM_INPUT_DATA + 40] * buffer[40] + weight[out_count * NUM_INPUT_DATA + 41] * buffer[41] + 
				weight[out_count * NUM_INPUT_DATA + 42] * buffer[42] + weight[out_count * NUM_INPUT_DATA + 43] * buffer[43] + 
				weight[out_count * NUM_INPUT_DATA + 44] * buffer[44] + weight[out_count * NUM_INPUT_DATA + 45] * buffer[45] + 
				weight[out_count * NUM_INPUT_DATA + 46] * buffer[46] + weight[out_count * NUM_INPUT_DATA + 47] * buffer[47] + 
				bias[out_count];

assign out_data = calc_out[18:7];

endmodule
