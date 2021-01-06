`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/03/2020 09:48:28 PM
// Design Name: 
// Module Name: testing_life
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

module testing_life();
    localparam N = 8;
    reg clk;
    reg nrst;
    reg [(N*N)-1:0] seeds;
    wire [(N*N)-1:0] cells;
    wire [N-1:0] wcells [N-1:0];
    
    genvar i;
    generate
        for (i = 0; i < N; i = i+1) begin
            assign wcells[i] = cells[(N*(N-i))-1 : N*(N-1-i)];
        end
    endgenerate
        
    GameOfLife #(.N(N)) itsmylife(
        .clk(clk),
        .nrst(nrst),
        .seeds(seeds),
        .cells(cells)
    );
    
    always #5 clk = ~clk;
    integer x;
    initial begin
        /*$monitor("%b", wcells);
        for(x = 0; x < N; x = x+1) begin
            $display("%b", wcells[x]);
        end
        
        $monitor("%b\n%b\n%b\n%b\n%b\n%b\n",
            cells[(N*N)    -1 : N*(N-1)],
            cells[(N*(N-1))-1 : N*(N-2)],
            cells[(N*(N-2))-1 : N*(N-3)],
            cells[(N*(N-3))-1 : N*(N-4)],
            cells[(N*(N-4))-1 : N*(N-5)],
            cells[(N*(N-5))-1 : N*(N-6)]
        );*/
        
        $monitor("%b\n%b\n%b\n%b\n%b\n%b\n%b\n%b\n",
            cells[(N*N)    -1 : N*(N-1)],
            cells[(N*(N-1))-1 : N*(N-2)],
            cells[(N*(N-2))-1 : N*(N-3)],
            cells[(N*(N-3))-1 : N*(N-4)],
            cells[(N*(N-4))-1 : N*(N-5)],
            cells[(N*(N-5))-1 : N*(N-6)],
            cells[(N*(N-6))-1 : N*(N-7)],
            cells[(N*(N-7))-1 : N*(N-8)]
        );
        
        clk <= 0;
        nrst <= 0;
        seeds <= 64'b01000000_00100000_11100000_00000000_00000000_00000000_00000000_00000000;
        //seeds <= 36'b010000_001000_111000_000000_000000_000000;
        #7;
        nrst <= 1;     
        #10000;
        
        /*
        $display("%b", wcells[0]);
        $display("%b", cells[35:30]);
        #200;*/
        $finish;
    end
endmodule
