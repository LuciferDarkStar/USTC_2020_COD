`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/05/07 21:51:46
// Design Name: 
// Module Name: ALUControl
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


module ALUControl(
    input   ALUOp,
    input [5:0] Funct,
    output[2:0] Sign//ALU控制信号
    );
assign Sign=(ALUOp==1'b1) ? 3'b001:3'b000;//ALUop为1时beq判断两数是否为0，为减法，否则为加法
endmodule
