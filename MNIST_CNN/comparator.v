
module comparator #(parameter INPUT_BITS = 12, NUM_CLASS = 10)
(
    clk, rst,
    valid_in,
			   
    //input_result
    in_data,
			   
    //output_result
    decision,
	valid_out
);  

input clk, rst, valid_in;
input signed [INPUT_BITS-1:0] in_data;

output reg [3:0] decision;
output reg valid_out;

reg signed [INPUT_BITS-1:0] buffer [0:NUM_CLASS-1];  
reg signed [INPUT_BITS-1:0] max;   
reg signed [INPUT_BITS-1:0] compare1_0, compare1_1, compare1_2, compare1_3, compare1_4,
							compare2_0, compare2_1, compare2_2, compare3_0, compare3_1;  

reg [3:0] buf_count;
reg [11:0] delay_count; // 4
reg state;

always @ (posedge clk) begin
    if(rst) begin
        valid_out <= 0;
		buf_count <= 0;
		delay_count <= 0;
		state <= 0;

    end
    else begin
	    if(valid_in == 1) begin
			buf_count <= buf_count + 1;
			if(buf_count == NUM_CLASS - 1) begin
				state <= 1;
			end
			buffer[buf_count] <= in_data;
			
		end
		else begin
			if(state == 1) begin
				delay_count <= delay_count + 1;
				if(delay_count == 12'd5) 
					valid_out <= 1;
				else 
					valid_out <= 0;

				// First compare
				if(buffer[0] >= buffer[1]) compare1_0 <= buffer[0];
				else compare1_0 <= buffer[1];
			
				if(buffer[2] >= buffer[3]) compare1_1 <= buffer[2];
				else compare1_1 <= buffer[3];

				if(buffer[4] >= buffer[5]) compare1_2 <= buffer[4];
				else compare1_2 <= buffer[5];

				if(buffer[6] >= buffer[7]) compare1_3 <= buffer[6];
				else compare1_3 <= buffer[7];

				if(buffer[8] >= buffer[9]) compare1_4 <= buffer[8];
				else compare1_4 <= buffer[9];

				// Second compare
				if(compare1_0 >= compare1_1) compare2_0 <= compare1_0;
				else compare2_0 <= compare1_1;

				if(compare1_2 >= compare1_3) compare2_1 <= compare1_2;
				else compare2_1 <= compare1_3;

				compare2_2 <= compare1_4;
		 
				// Third compare
				if(compare2_0 >= compare2_1) compare3_0 <= compare2_0;
				else compare3_0 <= compare2_1;

				compare3_1 <= compare2_2;

				// Last compare   
				if(compare3_0 >= compare3_1) max <= compare3_0;
				else max <= compare3_1;
		  
				// Output Index
				if(max == buffer[0])
					decision <= 4'b0000;
				else if(max == buffer[1])
					decision <= 4'b0001;
				else if(max == buffer[2])
					decision <= 4'b0010;
				else if(max == buffer[3])
					decision <= 4'b0011;
				else if(max == buffer[4])
					decision <= 4'b0100;
				else if(max == buffer[5])
					decision <= 4'b0101;
				else if(max == buffer[6])
					decision <= 4'b0110;
				else if(max == buffer[7])
					decision <= 4'b0111;
				else if(max == buffer[8])
					decision <= 4'b1000;
				else if(max == buffer[9])
					decision <= 4'b1001;
				else 
					decision <= decision; // DO NOTHING on Useless Values
			end
		end
	end
end
	
endmodule
