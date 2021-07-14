`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/06/01 22:24:32
// Design Name: 
// Module Name: alu
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

`define A_NOP 5'd00 //nop
`define A_ADD 5'd01 //signed_add
`define A_SUB 5'd02 //signed_sub
`define A_AND 5'd03 //and
`define A_OR  5'd04 //or
`define A_XOR 5'd05 //xor
`define A_NOR 5'd06 //nor
`define A_ADDU 5'd07 //unsigned_add
`define A_SUBU 5'd08 //unsigned_sub
`define A_SLT 5'd09 //slt
`define A_SLTU 5'd10 //unsigned_slt
`define A_SLL 5'd11 //sll
`define A_SRL 5'd12 //srl
`define A_SRA 5'd13 //sra
`define A_MOV 5'd14 //movz,movn
`define A_LUI 5'd15 //lui
module alu(
    input [31:0] alu_a,//�޷����͵ģ�����и��������Բ���洢
    input [31:0] alu_b,
    input [4:0] alu_op,
    output reg [31:0] alu_out

    );
	always@(*)
		case (alu_op)
			`A_NOP: alu_out = 0;
			`A_ADD: alu_out = alu_a + alu_b;
			`A_SUB: alu_out = alu_a - alu_b;
			`A_AND: alu_out = alu_a & alu_b;
			`A_OR : alu_out = alu_a | alu_b;
			`A_XOR: alu_out = alu_a ^ alu_b;
			`A_NOR: alu_out = ~(alu_a | alu_b);
			`A_ADDU: alu_out = alu_a + alu_b;
			`A_SUBU: alu_out = alu_a - alu_b;
			`A_SLT: //a<b(signed) return 1 else return 0;
				begin
					if(alu_a[31] == alu_b[31]) alu_out = (alu_a < alu_b) ? 32'b1 : 32'b0;
					//���ڲ���signed�ı������ͣ�����ͱȽ���Ϊ�޷��ţ�����Ȼ���Դ洢�з������������൱�����и�����λ�ж�
					//��λ��ȣ���ͬ�������ֱ�ӱȽϣ����ͬ��������31λ��ģ�ԭ���ʹ����ͬ��������31λ�����룩��ģ���Ȼ��ԭ����
					else alu_out = (alu_a[31] < alu_b[31]) ? 32'b0 : 32'b1;//��������ֱ�ӱȽϷ���
				end
			/*`A_SLT://��2��ʹ��$signed()
				alu_out = ($signed(alu_a) < $signed(alu_b)) ? 32'b1 : 32'b0;*/
			`A_SLTU: alu_out = (alu_a < alu_b) ? 32'b1 : 32'b0;
			`A_SLL: alu_out = alu_b << alu_a;
			`A_SRL: alu_out = alu_b >> alu_a;
			`A_SRA: alu_out = $signed(alu_b) >>> alu_a;
			//ʹ��>>>Ϊ�������ƣ���λ�����ţ�Ӧ��ע�⣬������޷�������>>>�����߼����ƣ���Ӧ��$signed
			`A_MOV: alu_out = alu_b;//ԭ��������൱��reg[rt],mov������Ҫͨ��alu������Ϊ��RType��ʽ����ͳһ
			`A_LUI: alu_out = alu_b << 16;
			default: ;
		endcase
endmodule

