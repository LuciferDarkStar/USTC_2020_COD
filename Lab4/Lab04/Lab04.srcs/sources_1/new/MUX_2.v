`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/05/14 22:51:52
// Design Name: 
// Module Name: MUX_2
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


module MUX_2
#(parameter WIDTH = 32)
(
    input   m,
    input   [WIDTH-1:0] a,b,
    output  [WIDTH-1:0] y
    );
assign y=(m==1)?b:a;   
endmodule
