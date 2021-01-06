
`define STATE_0  3'b000
`define STATE_1  3'b001
`define STATE_2  3'b010
`define STATE_3  3'b011
`define STATE_4  3'b100
`define STATE_5  3'b101
`define STATE_6  3'b110
`define STATE_7  3'b111


module LifeCell(
	input clk,
	input nrst,
	input seed,
	input [7:0] neighbors,
	output reg alive
);
    reg [2:0] state;
    reg [1:0] sum;
    reg done;
     
	always @ (posedge clk)
		if (nrst == 0) begin
            alive <= seed;
			state <= `STATE_0;
		end
		else 
			case(state)
				`STATE_0: begin
					done <= 0;
					sum <= neighbors[0] + neighbors[1];
				    state <= `STATE_1;
				end
				`STATE_1: begin
				    sum <= sum + neighbors[2];
				    state <= `STATE_2;
				end
				`STATE_2: begin
				    if(sum==2'd3 && neighbors[3])
				        done <= 1;
				    else
				        sum <= sum + neighbors[3];
				    state <= `STATE_3;
				end
				`STATE_3: begin
				    if(sum==2'd3 && neighbors[4] && !done) 
				        done <= 1;
				    else
				        sum <= sum + neighbors[4];
				    state <= `STATE_4;
				end
				`STATE_4: begin
				    if(sum==2'd3 && neighbors[5] && !done) 
				        done <= 1;
				    else
				        sum <= sum + neighbors[5];
				    state <= `STATE_5;
				end
				`STATE_5: begin
				    if(sum==2'd3 && neighbors[6] && !done) 
				        done <= 1;
				    else
				        sum <= sum + neighbors[6];
				    state <= `STATE_6;
				end
				`STATE_6: begin
				    if(sum==2'd3 && neighbors[7] && !done) 
				        done <= 1;
				    else
				        sum <= sum + neighbors[7];
				    state <= `STATE_7;
				end
				`STATE_7: begin
				    if(!done) begin
                        if(sum == 2'd3)
                            alive <= 1;
                        if(sum < 2'd2)
                            alive <= 0;
				    end
				    else
				        alive <= 0;
				    state <= `STATE_0;
				end
			endcase
endmodule