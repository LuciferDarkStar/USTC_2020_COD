`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/05/14 22:53:15
// Design Name: 
// Module Name: MUX_4
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


module MUX_4
#(parameter WIDTH = 32)
(
    input   [1:0]    m,
    input   [WIDTH-1:0] a,b,c,d,
    output  [WIDTH-1:0] y
    );
assign y=(m==2'b0)?a:(m==2'b1)?b:(m==2'b10)?c:d;
endmodule
