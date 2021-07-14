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
assign RegDst=(OpCode == 6'b0)?1'b1:1'b0;//add时写地址为rd否则为rt
assign jump=(OpCode == 6'b10)?1'b1:1'b0;//是否为J指令
assign Branch=(OpCode == 6'b100)?1'b1:1'b0;//是否为beq指令
assign MemRead=(OpCode == 6'b100011)?1'b1:1'b0;//是否为lw
assign MemtoReg=(OpCode == 6'b100011)?1'b1:1'b0;//是否为lw
assign ALUOp=(OpCode == 6'b100)?1'b1:1'b0;//beq时为减法判断是否为0，否则均为加法
assign MemWrite=(OpCode == 6'b101011)?1'b1:1'b0;//是否为sw
assign ALUSrc=((OpCode == 6'b0)|(OpCode == 6'b100))? 1'b0 : 1'b1;//add和beq时为0，其他为1
assign RegWrite=(OpCode == 6'b1000|OpCode == 6'b0|OpCode == 6'b100011)?1'b1:1'b0;//是否写回寄存器
endmodule
