`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/05/14 21:08:24
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
    input   clk,
    input   rst,
    input   [5:0]   opcode,
    output  reg PCWriteCond,
    output  reg PCWrite,
    output  reg MemWrite,
    output  reg IRWrite,
    output  reg RegWrite,
    output  reg lorD,
    output  reg MemRead,
    output  reg MemtoReg,
    output  reg [1:0]   PCSource,
    output  reg ALUOp,
    output  reg [1:0]   ALUSrcB,
    output  reg ALUSrcA,
    output  reg RegDst     
    );
reg [3:0]   state,next_state;

always@(posedge clk,posedge rst)
begin
    if(rst)
        state<=4'b0;
    else
        state<=next_state;
end

always@(*)
begin
    case(state)
        4'b0000:
            begin
                MemRead=1'b1;
                lorD=1'b0;
                ALUSrcA=1'b0;
                ALUSrcB=2'b1;
                ALUOp=0;
                PCSource=2'b0;
                PCWrite=1'b1;
                PCWriteCond=1'b0;
                MemWrite=1'b0;
                IRWrite=1'b1;
                RegWrite=1'b0;
                next_state=4'b0001;
            end
        4'b0001:
            begin
                IRWrite=1'b0;
                PCWrite=1'b0;
                ALUSrcA=1'b0;
                ALUSrcB=2'b11;
                ALUOp=0;
                if((opcode==6'b100011)||(opcode==6'b101011))//lw»òsw
                    next_state=4'b0010;
                else    if((opcode==6'b000000)||(opcode==6'b001000))//RÖ¸Áî
                            next_state=4'b0110;
                else    if(opcode==6'b000100)//beq
                            next_state=4'b1000;
                else    if(opcode==6'b000010)//J
                            next_state=4'b1001;
            end
        4'b0010:
            begin
                ALUSrcA=1'b1;
                ALUSrcB=2'b10;
                ALUOp=0;
                if(opcode==6'b100011)
                    next_state=4'b0011;
                else
                    next_state=4'b0101;
            end
        4'b0011:
            begin
                MemRead=1'b1;
                lorD=1'b1;
                next_state=4'b0100;
            end
        4'b0100:
            begin
                RegDst=1'b0;
                RegWrite=1'b1;
                MemtoReg=1'b1;
                next_state=4'b0000;
            end
        4'b0101:
            begin
                MemWrite=1'b1;
                lorD=1'b1;
                next_state=4'b0000;
            end
        4'b0110:
            begin
                ALUSrcA=1'b1;
                if(opcode==6'b000000)
                    ALUSrcB=2'b0;
                else
                    ALUSrcB=2'b10;
                ALUOp=0;
                next_state=4'b0111;
            end
        4'b0111:
            begin
                if(opcode==6'b000000)
                    RegDst=1'b1;
                else
                    RegDst=1'b0;
                RegWrite=1'b1;
                MemtoReg=1'b0;
                next_state=4'b0000;
            end
        4'b1000:
            begin
                ALUSrcA=1'b1;
                ALUSrcB=2'b0;
                ALUOp=1;
                PCWriteCond=1'b1;
                PCSource=2'b01;
                next_state=4'b0000;
            end
        4'b1001:
            begin
                PCWrite=1'b1;
                PCSource=2'b10;
                next_state=4'b0000;
            end
        default:next_state=4'b0000;
    endcase 
end
endmodule
