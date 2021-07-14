`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/05/15 22:40:49
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
reg     [8:0]   m_rf_addr;
wire    [31:0]  rf_data;
wire    [31:0]  m_data;
wire     [31:0]  Instruction,Memdata_r,A,B,ALUOut;

wire    [1:0]   PCSource;
wire    PCwe;
wire    lorD;
wire    MemWrite;
wire    IRWrite;
wire    RegDst;
wire    MemtoReg;
wire    RegWrite;
wire    [2:0]   ALUm;
wire    ALUSrcA;
wire    [1:0]   ALUSrcB;
wire    zero;
//相关按钮去抖动
Jitter_clr jitter_clr1(.clk(clk),.button(step),.button_clean(step_clean));
Jitter_clr jitter_clr2(.clk(clk),.button(inc),.button_clean(inc_clean));
Jitter_clr jitter_clr3(.clk(clk),.button(dec),.button_clean(dec_clean));
//相关按钮取边沿
EDG edg1(.clk(clk),.rst(rst),.y(step_clean),.p(step_fin));
EDG edg2(.clk(clk),.rst(rst),.y(inc),.p(inc_fin));
EDG edg3(.clk(clk),.rst(rst),.y(dec_clean),.p(dec_fin));

CPU cpu(rst,clock,read,m_rf_addr,PCSource,PCwe,lorD,MemWrite,IRWrite,RegDst,
        MemtoReg,RegWrite,ALUm,ALUSrcA,ALUSrcB,zero,Instruction,Memdata_r,A,B,
        ALUOut,rf_data,m_data,PC);
assign  clock=(read==1)?1'b0:((succ==1)?clk:step_fin);  
assign  led=(sel==0)?{7'b0,m_rf_addr}:{PCSource,PCwe,lorD,MemWrite,IRWrite,RegDst,MemtoReg,RegWrite,ALUm,ALUSrcA,ALUSrcB,zero};

always@(posedge clk or posedge rst)
begin
    if(rst)
        m_rf_addr<=9'b0;
    else if((inc_fin==1'b1)&(dec_fin==1'b0))
    m_rf_addr<=m_rf_addr+9'b1;
    else if((dec_fin==1'b1)&(inc_fin==1'b0))
    m_rf_addr<=m_rf_addr-9'b1;
    else
    m_rf_addr<=m_rf_addr;
end

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
    seg=PC;
    else if(sel==3'b010)
        seg=Instruction;
    else if(sel==3'b011)
        seg=Memdata_r;
    else if(sel==3'b100)
        seg=A;
    else if(sel==3'b101)
        seg=B;
    else if(sel==3'b110)
        seg=ALUOut;
    else if(sel==3'b111)
        seg=0;
    end
end
endmodule
