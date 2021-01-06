
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
		if (nrst == 0)
			state <= `STATE_0;
		else 
			case(state)
				`STATE_0: begin
                    alive <= seed;
					sum <= 0;
				    state <= `STATE_1;
				end
				`STATE_1:
				    if ((neighbors[0] + neighbors[1] + neighbors[2] + neighbors[3]) == 4) begin
				        done <= 1;
				        state <= `STATE_4; 
				    end
				    else begin
                        done <= 0;
                        sum <= neighbors[0] + neighbors[1] + neighbors[2];
                        state <= `STATE_2;
				    end
				`STATE_2:
				    if (done) begin
				        if(!nrst && neighbors==2) alive <= 1;
				        state <= `STATE_7;
				    end
				    else
                        if(sum==2'd3 && neighbors[3]) begin
                            done <= 1;
                            state <= `STATE_6;
                        end
                        else begin
                            sum <= sum + neighbors[3];
                            state <= `STATE_3;
                        end
				`STATE_3:
				    if (done) begin
				        if(!nrst && neighbors==3) alive <= 1;
				        state <= `STATE_2;
				    end
				    else          
                        if(sum==2'd3 && neighbors[4]) begin
                            done <= 1;
                            state <= `STATE_5;
                        end
                        else begin
                            sum <= sum + neighbors[4];
                            state <= `STATE_4;
                        end
				`STATE_4:
				    if (done)begin
				        if(!nrst && neighbors==4) alive <= 0;
				        state <= `STATE_6;
				    end
				    else           
                        if(sum==2'd3 && neighbors[5]) begin 
                            done <= 1;
                            state <= `STATE_3;
                        end
                        else begin
                            sum <= sum + neighbors[5];
                            state <= `STATE_5;
                        end
				`STATE_5: 
				    if (done) begin
				        if(!nrst && neighbors==5) alive <= 1;
				        state <= `STATE_3;
				    end
				    else            
                        if(sum==2'd3 && neighbors[6]) begin 
                            done <= 1;
                            state <= `STATE_2;
                        end
                        else begin
                            sum <= sum + neighbors[6];
                            state <= `STATE_6;
                        end
				`STATE_6: begin
				    if (done) begin
				        if(!nrst && neighbors==6) alive <= 0;
				        state <= `STATE_5;
				    end
				    else 
                        if(sum==2'd3 && neighbors[7]) 
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
                    state <= `STATE_1;
				end
			endcase
endmodule