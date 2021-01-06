`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/03/2020 09:55:33 AM
// Design Name: 
// Module Name: BigMachine
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module GameOfLife
    #(parameter N = 4)(
    input clk,
    input nrst,
    input  [(N*N)-1:0] seeds,
    output [(N*N)-1:0] cells
    );
    genvar i,j;
    generate
        for (i = 0; i < N; i = i+1) begin : cat
            for (j = 0; j < N; j = j+1) begin : dog
                LifeCell lc(
                    .clk(clk),
                    .nrst(nrst),
                    .seed(seeds[i*N + j]),
                    .neighbors({cells[((i==0)?N-1:i-1)*N + ((j==0)?N-1:j-1)],
                                cells[((i==0)?N-1:i-1)*N + ( j )%N],
                                cells[((i==0)?N-1:i-1)*N + ((j==N-1)?0:j+1)],
                                cells[(( i )%N)*N + ((j==0)?N-1:j-1)],
                                cells[(( i )%N)*N + (j+1)%N],
                                cells[((i==N-1)?0:i+1)*N + ((j==0)?N-1:j-1)],
                                cells[((i==N-1)?0:i+1)*N + ( j )],
                                cells[((i==N-1)?0:i+1)*N + ((j==N-1)?0:j+1)]                   
                              }),
                    .alive(cells[i*N + j])
                );
            end
        end
    endgenerate   
endmodule
