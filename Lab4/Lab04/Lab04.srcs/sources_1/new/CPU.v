`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/05/14 21:06:39
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
    input   read,
    input   [8:0]   m_rf_addr,
    output  [1:0]   PCSource,
    output  PCwe,
    output  lorD,
    output  MemWrite,
    output  IRWrite,
    output  RegDst,
    output  MemtoReg,
    output  RegWrite,
    output  [2:0]   ALUm,
    output  ALUSrcA,
    output  [1:0]   ALUSrcB,
    output  zero,
    output  reg     [31:0]  Instruction,
    output  reg     [31:0]  Memdata_r,
    output  reg     [31:0]  A,
    output  reg     [31:0]  B,
    output  reg     [31:0]  ALUOut,
    output  [31:0]  rf_data,//寄存器数据
    output  [31:0]  m_data,//mem数据
    output  reg     [31:0]  PC
    );
//reg     [31:0]  PC;
wire    [31:0]  PC_next;
//reg     [31:0]  Instruction,Memdata_r;//指令和数据寄存器
wire    [31:0]  MemData,ALU_result,Read_data1,Read_data2,Write_data,ALU_OP1,ALU_OP2;
wire    [4:0]   Write_register;
//reg     [31:0]  A,B;
//reg     [31:0]  ALUOut;
wire    [8:0]   Address,addr;
wire    [4:0]   rf_addr;
//控制信号
//wire    PCwe;
wire    PCWriteCond;
wire    PCWrite;
//wire    lorD;
wire    MemRead;
//wire    MemWrite;
//wire    MemtoReg;
//wire    IRWrite;
//wire    [1:0]   PCSource;
wire    ALUOp;
//wire    [2:0]   ALUm;
//wire    [1:0]   ALUSrcB;
//wire    ALUSrcA;
//wire    RegWrite;
//wire    RegDst;
//wire    zero;
wire    zf,cf,of;   

assign addr=(read==1)?m_rf_addr:Address;
assign  m_data=MemData;
assign  rf_data=Read_data1;
assign  rf_addr=(read==1)?m_rf_addr[4:0]:Instruction[25:21];

Mem mem(.a(addr),.d(B),.clk(clk),.we(MemWrite),.spo(MemData));

RF  Registers(.clk(clk),.ra0(rf_addr),.rd0(Read_data1),
                .ra1(Instruction[20:16]),.rd1(Read_data2),
                .wa(Write_register),.we(RegWrite),.wd(Write_data));

ALU alu(.y(ALU_result),.zf(zf),.cf(cf),.of(of),.a(ALU_OP1),.b(ALU_OP2),.m(ALUm));

Control control(.clk(clk),.rst(rst),.opcode(Instruction[31:26]),
                .PCWriteCond(PCWriteCond),.PCWrite(PCWrite),.MemWrite(MemWrite),
                .IRWrite(IRWrite),.RegWrite(RegWrite),.lorD(lorD),.MemRead(MemRead),
                .MemtoReg(MemtoReg),.PCSource(PCSource),.ALUOp(ALUOp),.ALUSrcB(ALUSrcB),
                .ALUSrcA(ALUSrcA),.RegDst(RegDst));

ALUControl  alu_c(.ALUOp(ALUOp),.ALUm(ALUm));

MUX_2 mux0(.m(lorD),.a(PC[10:2]),.b(ALUOut[10:2]),.y(Address));
MUX_2 mux1(.m(RegDst),.a(Instruction[20:16]),.b(Instruction[15:11]),.y(Write_register));
MUX_2 mux2(.m(MemtoReg),.a(ALUOut),.b(Memdata_r),.y(Write_data));
MUX_2 mux3(.m(ALUSrcA),.a(PC),.b(A),.y(ALU_OP1));
MUX_4 mux4(.m(ALUSrcB),.a(B),.b(32'b100),.c({16'b0,Instruction[15:0]}),.d({14'b0,Instruction[15:0],2'b0}),.y(ALU_OP2));
MUX_3 mux5(.m(PCSource),.a(ALU_result),.b(ALUOut),.c({PC[31:28],Instruction[25:0],2'b00}),.y(PC_next));

assign  PCwe=((PCWrite==1)||((PCWriteCond==1)&&(zero==1)));
assign  zero=(zf==1&&cf==0&&of==0);

always@(posedge clk,posedge rst)
begin
    Memdata_r<=MemData;
    ALUOut<=ALU_result;
    A<=Read_data1;
    B<=Read_data2;
    if(rst)
        PC<=32'b0;
    else
        if(PCwe)
           PC<=PC_next;
    if(IRWrite)
        Instruction<=MemData;
end
endmodule
