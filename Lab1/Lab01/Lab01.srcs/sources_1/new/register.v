`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/04/24 22:01:42
// Design Name: 
// Module Name: register
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


module register
#(parameter WIDTH = 32)
(
    input [WIDTH-1:0] a,
    output reg [WIDTH-1:0] y,
    input clk,
    input en,
    input rst
);
always @(posedge clk or posedge rst)
if(rst)
    y=0;
else
    if(en)
        y=a;
endmodule
