`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/05/10 11:00:07
// Design Name: 
// Module Name: DBU
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


module DBU(
    input   succ,
    input   clk,
    input   rst,
    input   read,//读使能
    input   step,
    input   [2:0] sel,
    input   m_rf,
    input   inc,
    input   dec,
    output  [15:0] led,//16位led
    output  [7:0]  an,//数码管片选
    output  reg [31:0]  seg//8个八段数码管
    );
wire    step_clean,inc_clean,dec_clean;
wire    step_fin,inc_fin,dec_fin;
wire    clock;
wire    [31:0] PC;
wire    [31:0] PC_next,Instruction,Read_data2,Read_data1,Alu_out;
wire    [31:0] Read_data;//DM中读出数据
reg     [7:0]   m_rf_addr;
wire    [31:0]  rf_data;
wire    [31:0]  m_data;
wire    jump;
wire    RegDst;
wire    Branch;
wire    MemRead;
wire    MemtoReg;
wire    [2:0] ALUOp;//ALU控制
wire    MemWrite;
wire    ALUSrc;
wire    RegWrite;
wire    zero;
//相关按钮去抖动
Jitter_clr jitter_clr1(.clk(clk),.button(step),.button_clean(step_clean));
Jitter_clr jitter_clr2(.clk(clk),.button(inc),.button_clean(inc_clean));
Jitter_clr jitter_clr3(.clk(clk),.button(dec),.button_clean(dec_clean));
//相关按钮取边沿
EDG edg1(.clk(clk),.rst(rst),.y(step_clean),.p(step_fin));
EDG edg2(.clk(clk),.rst(rst),.y(inc_clean),.p(inc_fin));
EDG edg3(.clk(clk),.rst(rst),.y(dec_clean),.p(dec_fin));

CPU cpu(.rst(rst),.clk(clock),.Read_data1(Read_data1),.PC(PC),.PC_next(PC_next),
        .Instruction(Instruction),.read(read),.m_rf_addr(m_rf_addr),.rf_data(rf_data),
        .m_data(m_data),.jump(jump),.RegDst(RegDst),.Branch(Branch),.MemRead(MemRead),
        .MemtoReg(MemtoReg),.Sign(ALUOp),.MemWrite(MemWrite),.ALUSrc(ALUSrc),
        .RegWrite(RegWrite),.zero(zero),.Read_data2(Read_data2),.Alu_out(Alu_out),
        .Read_data(Read_data));

assign clock=(read==1)?1'b0:((succ==1)?clk:step_fin);

always@(posedge clk or posedge rst)
begin
    if(rst)
        m_rf_addr<=8'b0;
    else if((inc_fin==1'b1)&(dec_fin==1'b0))
    m_rf_addr<=m_rf_addr+8'b1;
    else if((dec_fin==1'b1)&(inc_fin==1'b0))
    m_rf_addr<=m_rf_addr-8'b1;
    else
    m_rf_addr<=m_rf_addr;
end
assign  led=(sel==0)?{8'b0,m_rf_addr}:{2'b00,sel,m_rf,jump,Branch,RegDst,RegWrite,MemRead,MemtoReg,MemWrite,ALUOp,ALUSrc,zero};
always@(*)
begin
    if(sel==3'b0)
    begin
        if(m_rf==1)
            seg=m_data;
        else
            seg=rf_data;
    end
    else
    begin
    if(sel==3'b001)
    seg=PC_next;
    else if(sel==3'b010)
        seg=PC;
    else if(sel==3'b011)
        seg=Instruction;
    else if(sel==3'b100)
        seg=Read_data1;
    else if(sel==3'b101)
        seg=Read_data2;
    else if(sel==3'b110)
        seg=Alu_out;
    else if(sel==3'b111)
        seg=Read_data;
    end
end
endmodule
