`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/05/14 22:27:04
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
    output[2:0] ALUm//ALU控制信号
    );
assign ALUm=(ALUOp==1'b1) ? 3'b001:3'b000;//ALUop为1时beq判断两数是否为0，为减法，否则为加法
endmodule
