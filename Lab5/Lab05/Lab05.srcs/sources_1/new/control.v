`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/06/01 22:40:00
// Design Name: 
// Module Name: control
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


module control(
	input clk,rst,
	input [5:0] Op, //instr[31:26]
	input [4:0] Rt, //instr[20:16]
	input [5:0] Funct,//instr[5:0]
	input [1:0] RsCMPRt,
	input [1:0] RsCMPZero,
	output reg [1:0] PCSrc, //0:+4,1:Branch,2:J,3:JR
	output reg RegDst,//0:RegWtaddr=rt,1:RegWtaddr=rd
	output reg ALUSrcASel,//0:RegRdout1,1:ShamtZeroExtended
	output reg [1:0] ALUSrcBSel, //0:RegRdout2,1:IMMSignExtended,2:IMMZeroExtended
	output reg [4:0] ALUControl,
	output reg DMemRead,//1:En
	output reg DMemWrite,//1:En
	output reg DMemtoReg,//0:Aluout,1:DMemout
	output reg RegWrite//1:En
    );
	reg [1:0] tmpsrc;
	always @(*)
	begin
	if(rst) 
		begin
			{{PCSrc},{RegDst},{ALUSrcASel},{ALUSrcBSel},{ALUControl},{DMemRead},{DMemWrite},{DMemtoReg},{RegWrite}}={{6'b00_0_0_00},{`A_NOP},{4'b0001}};
		end
	else
				case(Op)
					6'b000000: //R-Type
						case(Funct)
						    6'b000000: //NOP                       
						        {{PCSrc},{RegDst},{ALUSrcASel},{ALUSrcBSel},{ALUControl},{DMemRead},{DMemWrite},{DMemtoReg },{RegWrite}}={{6'b00_1_1_00},{`A_SLL},{4'b0000}}; 
							6'b100000: //ADD
								{{PCSrc},{RegDst},{ALUSrcASel},{ALUSrcBSel},{ALUControl},{DMemRead},{DMemWrite},{DMemtoReg},{RegWrite}}={{6'b00_1_0_00},{`A_ADD},{4'b0001}};
						endcase
					6'b000010: //J,无条件跳转
						{{PCSrc},{RegDst},{ALUSrcASel},{ALUSrcBSel},{ALUControl},{DMemRead},{DMemWrite},{DMemtoReg},{RegWrite}}={{6'b10_z_z_zz},{`A_NOP},{4'b00z0}};
					6'b000100: //BEQ,Reg[rs]==Reg[rt]则跳转,RsCMPRt=01(==),则PCSrc=01，否则PCSrc=00(不跳转)
						{{PCSrc},{RegDst},{ALUSrcASel},{ALUSrcBSel},{ALUControl},{DMemRead},{DMemWrite},{DMemtoReg},{RegWrite}}={{{1'b0},{RsCMPRt[0]}},{4'bz_z_zz},{`A_NOP},{4'b00z0}};
					6'b001000: //ADDI,注意RegDst=0,AluBSrcSel=01(IMMSignExtended),下面三个同理
						{{PCSrc},{RegDst},{ALUSrcASel},{ALUSrcBSel},{ALUControl},{DMemRead},{DMemWrite},{DMemtoReg},{RegWrite}}={{6'b00_0_0_01},{`A_ADD},{4'b0001}};
					6'b100011: //LW,注意RegDst=0(写到Reg[rt]),AluBSrcSel=01(IMMSignExtended),DMemtoReg=1(来自DMem),
						{{PCSrc},{RegDst},{ALUSrcASel},{ALUSrcBSel},{ALUControl},{DMemRead},{DMemWrite},{DMemtoReg},{RegWrite}}={{6'b00_0_0_01},{`A_ADD},{4'b1011}};
					6'b101011: //SW,注意RegDst=x(不写Reg),AluBSrcSel=01(IMMSignExtended)
						{{PCSrc},{RegDst},{ALUSrcASel},{ALUSrcBSel},{ALUControl},{DMemRead},{DMemWrite},{DMemtoReg},{RegWrite}}={{6'b00_z_0_01},{`A_ADD},{4'b01z0}};
					default: ;
				endcase		
	end
endmodule
