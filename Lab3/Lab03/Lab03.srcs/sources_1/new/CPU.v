`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/05/07 20:34:51
// Design Name: 
// Module Name: CPU
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


module CPU(
    input   rst,
    input   clk,
    input   read,//使用DBU读CPU内部数据使能
    input   [7:0]   m_rf_addr,//地址
    output  [31:0]  rf_data,//寄存器数据
    output  [31:0]  m_data,//mem数据
    output  reg  [31:0] PC,
    output  [31:0] PC_next,
    output  [31:0] Instruction,
    output  [31:0] Read_data1,//寄存器堆读出数据
    output  [31:0] Read_data2,
    output  [31:0] Alu_out,//ALU输出
    output  [31:0] Read_data,//DM中读出数据
    //控制信号
    output  jump,
    output  RegDst,
    output  Branch,
    output  MemRead,
    output  MemtoReg,
    output  [2:0] Sign,//ALU控制
    output  MemWrite,
    output  ALUSrc,
    output  RegWrite,
    output  zero
    );


wire [31:0] PC_plus_4;//PC+4
wire [31:0] Jump_addr;//跳转地址
wire [4:0]  Write_R;//要写的寄存器地址
wire [31:0] Write_D;//写端口数据
wire [31:0] OP;//ALU的第二个操作数
wire [31:0] add_imm;//指令15-0拓展
wire [31:0] mux0_out;//MUX0的输出
wire zf,cf,of;//ALU相关输出
wire [4:0]  rf_addr;
wire [7:0]  dm_addr;
reg  [31:0] NPC;

//控制信号
wire  ALUOp;

assign  m_data=Read_data;
assign  rf_data=Read_data1;
assign  rf_addr=(read==1)?m_rf_addr[4:0]:Instruction[25:21];
assign  dm_addr=(read==1)?m_rf_addr:Alu_out[9:2];

IM im(.a(PC[9:2]),.spo(Instruction));
DM dm(.a(dm_addr),.d(Read_data2),.clk(~clk),.we(MemWrite),.spo(Read_data));

Control control(.OpCode(Instruction[31:26]),.jump(jump),.RegDst(RegDst),.Branch(Branch),
                .MemRead(MemRead),.MemtoReg(MemtoReg),.ALUOp(ALUOp),.MemWrite(MemWrite),
                .ALUSrc(ALUSrc),.RegWrite(RegWrite));

ALUControl Alucontrol(.ALUOp(ALUOp),.Funct(Instruction[5:0]),.Sign(Sign));

register_file Registers(.clk(~clk),.ra0(rf_addr),.rd0(Read_data1),.ra1(Instruction[20:16]),
                        .rd1(Read_data2),.wa(Write_R),.we(RegWrite),.wd(Write_D));

ALU Alu(.m(Sign),.a(Read_data1),.b(OP),.y(Alu_out),.zf(zf),.cf(cf),.of(of));
//依据数据通路图，从上到下，从左到右MUX
MUX mux0(.m(zero&Branch),.a(PC_plus_4),.b(({add_imm[29:0],2'b00}+PC_plus_4)),.y(mux0_out));
MUX mux1(.m(jump),.a(mux0_out),.b(Jump_addr),.y(PC_next));
MUX mux2(.m(RegDst),.a(Instruction[20:16]),.b(Instruction[15:11]),.y(Write_R));
MUX mux3(.m(ALUSrc),.a(Read_data2),.b(add_imm),.y(OP));
MUX mux4(.m(MemtoReg),.a(Alu_out),.b(Read_data),.y(Write_D));

assign PC_plus_4=PC+32'b100;//PC+4
assign Jump_addr={PC_plus_4[31:28], Instruction[25:0], 2'b00};
assign add_imm={16'b0,Instruction[15:0]};
assign zero=(zf==1'b1&&cf==1'b0&&of==1'b0);

always @(posedge rst or posedge clk)
		if (rst)
			PC <= 32'b0;
		else
			PC <= NPC;

always @(negedge clk or posedge rst)
    if(rst)
        NPC<=32'b0;
    else
        NPC<=PC_next;
endmodule