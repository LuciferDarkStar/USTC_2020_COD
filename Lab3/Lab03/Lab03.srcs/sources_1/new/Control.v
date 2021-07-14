`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/05/07 21:01:30
// Design Name: 
// Module Name: Control
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


module Control(
    input   [5:0] OpCode,
    output  jump,
    output  RegDst,
    output  Branch,
    output  MemRead,
    output  MemtoReg,
    output  ALUOp,
    output  MemWrite,
    output  ALUSrc,
    output  RegWrite
    );
assign RegDst=(OpCode == 6'b0)?1'b1:1'b0;//addʱд��ַΪrd����Ϊrt
assign jump=(OpCode == 6'b10)?1'b1:1'b0;//�Ƿ�ΪJָ��
assign Branch=(OpCode == 6'b100)?1'b1:1'b0;//�Ƿ�Ϊbeqָ��
assign MemRead=(OpCode == 6'b100011)?1'b1:1'b0;//�Ƿ�Ϊlw
assign MemtoReg=(OpCode == 6'b100011)?1'b1:1'b0;//�Ƿ�Ϊlw
assign ALUOp=(OpCode == 6'b100)?1'b1:1'b0;//beqʱΪ�����ж��Ƿ�Ϊ0�������Ϊ�ӷ�
assign MemWrite=(OpCode == 6'b101011)?1'b1:1'b0;//�Ƿ�Ϊsw
assign ALUSrc=((OpCode == 6'b0)|(OpCode == 6'b100))? 1'b0 : 1'b1;//add��beqʱΪ0������Ϊ1
assign RegWrite=(OpCode == 6'b1000|OpCode == 6'b0|OpCode == 6'b100011)?1'b1:1'b0;//�Ƿ�д�ؼĴ���
endmodule
