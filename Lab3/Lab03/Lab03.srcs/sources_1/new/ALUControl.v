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
    output[2:0] Sign//ALU�����ź�
    );
assign Sign=(ALUOp==1'b1) ? 3'b001:3'b000;//ALUopΪ1ʱbeq�ж������Ƿ�Ϊ0��Ϊ����������Ϊ�ӷ�
endmodule
