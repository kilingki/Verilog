module mxp_relu #( parameter CONV_BIT = 12, HALF_WIDTH = 12, HALF_HEIGHT = 12, HALF_WIDTH_BIT = 4 )
(
    clk, rst,
    valid_in,
    conv_out_1, conv_out_2, conv_out_3,
	
    max_value_1, max_value_2, max_value_3,
    valid_out
);

input clk, rst, valid_in; 
input signed [CONV_BIT - 1 : 0] conv_out_1, conv_out_2, conv_out_3;

output reg [CONV_BIT - 1 : 0] max_value_1, max_value_2, max_value_3; 
output reg valid_out;

reg signed [CONV_BIT - 1 : 0] buffer_1 [0 : HALF_WIDTH - 1];
reg signed [CONV_BIT - 1 : 0] buffer_2 [0 : HALF_WIDTH - 1];
reg signed [CONV_BIT - 1 : 0] buffer_3 [0 : HALF_WIDTH - 1];

reg [HALF_WIDTH_BIT - 1 : 0] pcount;
reg state; // 0 : p0,p1 // 1 : p2,p3, out
reg flag; // 0 : input // 1 : Compare

always @ (posedge clk) begin
    if(rst) begin
        state <= 0;
        pcount <= 0;
        valid_out <= 0;
        flag <= 0;
    end
    else begin

        // Only Valid Value
        if(valid_in == 1) begin
            // Toggle Flag 
            flag <= ~flag;
            // 1 Count to 2 Clock
            if(flag == 1) begin
                pcount <= pcount + 1;
                if(pcount == HALF_WIDTH - 1) begin
                    state <= ~state;
                    pcount <= 0;
                end
            end
            // First line
            if(state == 0) begin
                //Input without Comparison
                if(flag == 0) begin
                    valid_out <= 0;
                    buffer_1[pcount] <= conv_out_1;
                    buffer_2[pcount] <= conv_out_2;
                    buffer_3[pcount] <= conv_out_3;
                end
                //Input with Comparison
                else begin
                    valid_out <= 0;
                    if(buffer_1[pcount] < conv_out_1)
                        buffer_1[pcount] <= conv_out_1;
                    if(buffer_2[pcount] < conv_out_2)
                        buffer_2[pcount] <= conv_out_2;
                    if(buffer_3[pcount] < conv_out_3)
                        buffer_3 [pcount] <= conv_out_3;
                end
            end
            // Second line
            else begin
                //Input with Comparison
                if(flag == 0) begin
                    valid_out <= 0;
                    if(buffer_1[pcount] < conv_out_1)
                        buffer_1[pcount] <= conv_out_1;
                    if(buffer_2[pcount] < conv_out_2)
                        buffer_2[pcount] <= conv_out_2;
                    if(buffer_3[pcount] < conv_out_3)
                        buffer_3[pcount] <= conv_out_3;
					
                end
                //Output with Comparison + ReLU
                else begin
                    valid_out <= 1;
                    // Channel 1
                    if(buffer_1[pcount] < conv_out_1) begin
                        if(conv_out_1 > 0)
                            max_value_1 <= conv_out_1;
                        else
                            max_value_1 <= 0;
                    end
                    else begin
                        if(buffer_1[pcount] > 0)
                            max_value_1 <= buffer_1[pcount];
                        else
                            max_value_1 <= 0;
                    end

                    // Channel 2
                    if(buffer_2[pcount] < conv_out_2) begin
                        if(conv_out_2 > 0)
                            max_value_2 <= conv_out_2;
                        else
                            max_value_2 <= 0;
                    end
                    else begin
                        if(buffer_2[pcount] > 0)
                            max_value_2 <= buffer_2[pcount];
                        else
                            max_value_2 <= 0;
                    end

                    // Channel 3
                    if(buffer_3[pcount] < conv_out_3) begin
                        if(conv_out_3 > 0)
                            max_value_3 <= conv_out_3;
                        else
                            max_value_3 <= 0;
                    end
                    else begin
                        if(buffer_3[pcount] > 0)
                            max_value_3 <= buffer_3[pcount];
                        else
                            max_value_3 <= 0;
                    end
                end
            end
        end
        else begin
            valid_out <= 0;
        end
    end
end

endmodule
