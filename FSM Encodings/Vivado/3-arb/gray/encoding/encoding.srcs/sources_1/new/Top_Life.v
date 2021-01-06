`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/04/2020 08:10:00 PM
// Design Name: 
// Module Name: Top_Life
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


module Top_Life #(parameter N = 23)(
    input clk,
    input nrst,
    output out0
    );
    reg [(N*N)-1:0] seeds;
    wire [(N*N)-1:0] cells;
    assign out0 = cells[0];
        
    GameOfLife #(.N(N)) itsmylife(
        .clk(clk),
        .nrst(nrst),
        .seeds(seeds),
        .cells(cells)
    );    
    
    always @ (posedge clk)
    if (nrst == 0)
        seeds <= 64'b01000000_00100000_11100000_00000000_00000000_00000000_00000000_00000000;
		
endmodule
