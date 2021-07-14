`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/04/24 21:58:35
// Design Name: 
// Module Name: MUX
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


module MUX
#(parameter WIDTH = 32)
(
    input   m,
    input   [WIDTH-1:0] a,b,
    output  [WIDTH-1:0] y    
);
assign y=(m==1)?b:a;
endmodule
