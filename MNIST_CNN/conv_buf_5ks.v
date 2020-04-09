module conv_buf_5ks #( parameter WIDTH = 28, HEIGHT = 28, DATA_BIT = 8 )
(
	clk, rst,
	in_data,
	
	out_data_0, out_data_1, out_data_2, out_data_3, out_data_4,
	out_data_5, out_data_6, out_data_7, out_data_8, out_data_9,
	out_data_10, out_data_11, out_data_12, out_data_13, out_data_14,
	out_data_15, out_data_16, out_data_17, out_data_18, out_data_19,
	out_data_20, out_data_21, out_data_22, out_data_23, out_data_24,
	
	valid_out
);

localparam KERNEL_SIZE = 5;

input clk, rst;
input [DATA_BIT - 1 : 0]in_data;

output reg [DATA_BIT - 1:0] out_data_0, out_data_1, out_data_2, out_data_3, out_data_4,
							out_data_5, out_data_6, out_data_7, out_data_8, out_data_9,
							out_data_10, out_data_11, out_data_12, out_data_13, out_data_14,
							out_data_15, out_data_16, out_data_17, out_data_18, out_data_19,
							out_data_20, out_data_21, out_data_22, out_data_23, out_data_24;
				
output reg valid_out;

reg [DATA_BIT - 1:0] buffer [0 : WIDTH * KERNEL_SIZE - 1];

reg [DATA_BIT - 1:0] buf_count; // Index of Buffer (28 * 5)
reg [4:0] w_count; // Index of width (28)
reg [4:0] h_count; // Index of height (28)
reg [2:0] buf_flag; // Flag of data processing 0 ~ 4
reg state; // 0 : initialize, 1: Output Selection

always @(posedge clk) begin
	if(rst) begin
		buf_count <= -1;
		w_count <= 0;
		h_count <= 0;
		buf_flag <= 0;
		state <= 0;
		valid_out <= 0;
	end
	else begin
	
		buf_count <= buf_count + 1;
		if(buf_count == WIDTH * KERNEL_SIZE - 1) begin
			buf_count <= 0;
		end
		buffer[buf_count] <= in_data;
		
		// Initialization
		if(!state) begin
			if(buf_count == WIDTH * KERNEL_SIZE - 1) begin
				state <= 1;
			end
		end
		
		// Output Selection
		else begin // state == 0
			w_count <= w_count + 1;
			
			// Useless Value
			if(w_count == WIDTH - 4) begin
				valid_out <= 0;
			end

			else if(w_count == WIDTH - 1) begin
				buf_flag <= buf_flag + 1;
				if(buf_flag == KERNEL_SIZE - 1) begin
					buf_flag <= 0;
				end
				
				w_count <= 0;
				if(h_count == HEIGHT - 5) begin
					h_count <= 0;
					state <= 0;
				end
				h_count <= h_count + 1;
				
			end
			
			else if(w_count == 0) begin
				valid_out <= 1;
			end
			
			// Buffer Output Selection
			if(buf_flag == 3'd0) begin 
				out_data_0 <= buffer[w_count];
				out_data_1 <= buffer[w_count + 1]; 
				out_data_2 <= buffer[w_count + 2]; 
				out_data_3 <= buffer[w_count + 3]; 
				out_data_4 <= buffer[w_count + 4];
				
				out_data_5 <= buffer[w_count + WIDTH]; 
				out_data_6 <= buffer[w_count + 1 + WIDTH]; 
				out_data_7 <= buffer[w_count + 2 + WIDTH]; 
				out_data_8 <= buffer[w_count + 3 + WIDTH]; 
				out_data_9 <= buffer[w_count + 4 + WIDTH];
				
				out_data_10 <= buffer[w_count + (WIDTH * 2)]; 
				out_data_11 <= buffer[w_count + 1 + (WIDTH * 2)]; 
				out_data_12 <= buffer[w_count + 2 + (WIDTH * 2)]; 
				out_data_13 <= buffer[w_count + 3 + (WIDTH * 2)]; 
				out_data_14 <= buffer[w_count + 4 + (WIDTH * 2)];
				
				out_data_15 <= buffer[w_count + (WIDTH * 3)]; 
				out_data_16 <= buffer[w_count + 1 + (WIDTH * 3)]; 
				out_data_17 <= buffer[w_count + 2 + (WIDTH * 3)]; 
				out_data_18 <= buffer[w_count + 3 + (WIDTH * 3)]; 
				out_data_19 <= buffer[w_count + 4 + (WIDTH * 3)];
				
				out_data_20 <= buffer[w_count + (WIDTH * 4)]; 
				out_data_21 <= buffer[w_count + 1 + (WIDTH * 4)]; 
				out_data_22 <= buffer[w_count + 2 + (WIDTH * 4)]; 
				out_data_23 <= buffer[w_count + 3 + (WIDTH * 4)]; 
				out_data_24 <= buffer[w_count + 4 + (WIDTH * 4)];
			end
			else if(buf_flag == 3'd1) begin 
				out_data_20 <= buffer[w_count]; 
				out_data_21 <= buffer[w_count + 1]; 
				out_data_22 <= buffer[w_count + 2]; 
				out_data_23 <= buffer[w_count + 3]; 
				out_data_24 <= buffer[w_count + 4];
				
				out_data_0 <= buffer[w_count + WIDTH]; 
				out_data_1 <= buffer[w_count + 1 + WIDTH]; 
				out_data_2 <= buffer[w_count + 2 + WIDTH]; 
				out_data_3 <= buffer[w_count + 3 + WIDTH]; 
				out_data_4 <= buffer[w_count + 4 + WIDTH];
				
				out_data_5 <= buffer[w_count + (WIDTH * 2)]; 
				out_data_6 <= buffer[w_count + 1 + (WIDTH * 2)]; 
				out_data_7 <= buffer[w_count + 2 + (WIDTH * 2)]; 
				out_data_8 <= buffer[w_count + 3 + (WIDTH * 2)]; 
				out_data_9 <= buffer[w_count + 4 + (WIDTH * 2)];
				
				out_data_10 <= buffer[w_count + (WIDTH * 3)]; 
				out_data_11 <= buffer[w_count + 1 + (WIDTH * 3)]; 
				out_data_12 <= buffer[w_count + 2 + (WIDTH * 3)]; 
				out_data_13 <= buffer[w_count + 3 + (WIDTH * 3)]; 
				out_data_14 <= buffer[w_count + 4 + (WIDTH * 3)];
				
				out_data_15 <= buffer[w_count + (WIDTH * 4)]; 
				out_data_16 <= buffer[w_count + 1 + (WIDTH * 4)]; 
				out_data_17 <= buffer[w_count + 2 + (WIDTH * 4)]; 
				out_data_18 <= buffer[w_count + 3 + (WIDTH * 4)]; 
				out_data_19 <= buffer[w_count + 4 + (WIDTH * 4)];
			end	
			else if(buf_flag == 3'd2) begin
				out_data_15 <= buffer[w_count]; 
				out_data_16 <= buffer[w_count + 1]; 
				out_data_17 <= buffer[w_count + 2]; 
				out_data_18 <= buffer[w_count + 3]; 
				out_data_19 <= buffer[w_count + 4];
				
				out_data_20 <= buffer[w_count + WIDTH]; 
				out_data_21 <= buffer[w_count + 1 + WIDTH]; 
				out_data_22 <= buffer[w_count + 2 + WIDTH]; 
				out_data_23 <= buffer[w_count + 3 + WIDTH]; 
				out_data_24 <= buffer[w_count + 4 + WIDTH];
				
				out_data_0 <= buffer[w_count + (WIDTH * 2)]; 
				out_data_1 <= buffer[w_count + 1 + (WIDTH * 2)]; 
				out_data_2 <= buffer[w_count + 2 + (WIDTH * 2)]; 
				out_data_3 <= buffer[w_count + 3 + (WIDTH * 2)]; 
				out_data_4 <= buffer[w_count + 4 + (WIDTH * 2)];
				
				out_data_5 <= buffer[w_count + (WIDTH * 3)]; 
				out_data_6 <= buffer[w_count + 1 + (WIDTH * 3)]; 
				out_data_7 <= buffer[w_count + 2 + (WIDTH * 3)]; 
				out_data_8 <= buffer[w_count + 3 + (WIDTH * 3)]; 
				out_data_9 <= buffer[w_count + 4 + (WIDTH * 3)];
				
				out_data_10 <= buffer[w_count + (WIDTH * 4)]; 
				out_data_11 <= buffer[w_count + 1 + (WIDTH * 4)]; 
				out_data_12 <= buffer[w_count + 2 + (WIDTH * 4)]; 
				out_data_13 <= buffer[w_count + 3 + (WIDTH * 4)]; 
				out_data_14 <= buffer[w_count + 4 + (WIDTH * 4)];
			end
			else if(buf_flag == 3'd3) begin
				out_data_10 <= buffer[w_count]; 
				out_data_11 <= buffer[w_count + 1]; 
				out_data_12 <= buffer[w_count + 2]; 
				out_data_13 <= buffer[w_count + 3]; 
				out_data_14 <= buffer[w_count + 4];
				
				out_data_15 <= buffer[w_count + WIDTH]; 
				out_data_16 <= buffer[w_count + 1 + WIDTH]; 
				out_data_17 <= buffer[w_count + 2 + WIDTH]; 
				out_data_18 <= buffer[w_count + 3 + WIDTH]; 
				out_data_19 <= buffer[w_count + 4 + WIDTH];
				
				out_data_20 <= buffer[w_count + (WIDTH * 2)]; 
				out_data_21 <= buffer[w_count + 1 + (WIDTH * 2)]; 
				out_data_22 <= buffer[w_count + 2 + (WIDTH * 2)]; 
				out_data_23 <= buffer[w_count + 3 + (WIDTH * 2)]; 
				out_data_24 <= buffer[w_count + 4 + (WIDTH * 2)];
				
				out_data_0 <= buffer[w_count + (WIDTH * 3)]; 
				out_data_1 <= buffer[w_count + 1 + (WIDTH * 3)]; 
				out_data_2 <= buffer[w_count + 2 + (WIDTH * 3)]; 
				out_data_3 <= buffer[w_count + 3 + (WIDTH * 3)]; 
				out_data_4 <= buffer[w_count + 4 + (WIDTH * 3)];
				
				out_data_5 <= buffer[w_count + (WIDTH * 4)]; 
				out_data_6 <= buffer[w_count + 1 + (WIDTH * 4)]; 
				out_data_7 <= buffer[w_count + 2 + (WIDTH * 4)]; 
				out_data_8 <= buffer[w_count + 3 + (WIDTH * 4)]; 
				out_data_9 <= buffer[w_count + 4 + (WIDTH * 4)];
			end
			else if(buf_flag == 3'd4) begin
				out_data_5 <= buffer[w_count]; 
				out_data_6 <= buffer[w_count + 1]; 
				out_data_7 <= buffer[w_count + 2]; 
				out_data_8 <= buffer[w_count + 3]; 
				out_data_9 <= buffer[w_count + 4];
				
				out_data_10 <= buffer[w_count + WIDTH]; 
				out_data_11 <= buffer[w_count + 1 + WIDTH]; 
				out_data_12 <= buffer[w_count + 2 + WIDTH]; 
				out_data_13 <= buffer[w_count + 3 + WIDTH]; 
				out_data_14 <= buffer[w_count + 4 + WIDTH];
				
				out_data_15 <= buffer[w_count + (WIDTH * 2)]; 
				out_data_16 <= buffer[w_count + 1 + (WIDTH * 2)]; 
				out_data_17 <= buffer[w_count + 2 + (WIDTH * 2)]; 
				out_data_18 <= buffer[w_count + 3 + (WIDTH * 2)]; 
				out_data_19 <= buffer[w_count + 4 + (WIDTH * 2)];
				
				out_data_20 <= buffer[w_count + (WIDTH * 3)]; 
				out_data_21 <= buffer[w_count + 1 + (WIDTH * 3)]; 
				out_data_22 <= buffer[w_count + 2 + (WIDTH * 3)]; 
				out_data_23 <= buffer[w_count + 3 + (WIDTH * 3)]; 
				out_data_24 <= buffer[w_count + 4 + (WIDTH * 3)];
				
				out_data_0 <= buffer[w_count + (WIDTH * 4)]; 
				out_data_1 <= buffer[w_count + 1 + (WIDTH * 4)]; 
				out_data_2 <= buffer[w_count + 2 + (WIDTH * 4)]; 
				out_data_3 <= buffer[w_count + 3 + (WIDTH * 4)]; 
				out_data_4 <= buffer[w_count + 4 + (WIDTH * 4)];
			end
			
		end
	end
end
endmodule
