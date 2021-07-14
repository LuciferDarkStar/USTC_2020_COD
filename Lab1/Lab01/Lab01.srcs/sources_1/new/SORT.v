`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/04/24 21:57:59
// Design Name: 
// Module Name: SORT
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


module SORT
#(
    parameter N = 32,
    parameter S0=3'b000,//载入
    parameter S1=3'b001,//x0与x1比较
    parameter S2=3'b010,//x1与x2比较
    parameter S3=3'b011,//x2与x3比较
    parameter S4=3'b100,//x0与x1比较
    parameter S5=3'b101,//x1与x2比较
    parameter S6=3'b110,//x0与x1比较
    parameter S7=3'b111//排序完成
)
(
    output reg [N-1:0] s0, s1, s2, s3, 	//排序后的四个数据（递增）
    output reg done, 				//排序结束标志
    input [N-1:0] x0, x1, x2, x3,	//原始输入数据
    input clk, rst				//时钟（上升沿有效）、复位（高电平有效）
);
reg [2:0] state,next_state;
reg m0,m1,m2,m3,m4,m5;
wire [N-1:0] i0,i1,i2,i3,i4,i5,r0,r1,r2,r3;
reg en0,en1,en2,en3;
wire cf;

MUX
    M0(.m(m0),.y(i0),.a(r0),.b(r2)),
    M1(.m(m1),.y(i1),.a(x0),.b(r1)),
    M2(.m(m2),.y(i2),.a(i0),.b(x1)),
    M3(.m(m3),.y(i3),.a(i5),.b(x2)),
    M4(.m(m4),.y(i4),.a(r2),.b(x3)),
    M5(.m(m5),.y(i5),.a(r1),.b(r3));//选择器部分
    
register
    R0(.clk(clk),.rst(rst),.en(en0),.a(i1),.y(r0)),
    R1(.clk(clk),.rst(rst),.en(en1),.a(i2),.y(r1)),
    R2(.clk(clk),.rst(rst),.en(en2),.a(i3),.y(r2)),
    R3(.clk(clk),.rst(rst),.en(en3),.a(i4),.y(r3));//寄存器部分
    
ALU alu(.m(3'b001),.cf(cf),.a(i0),.b(i5));//ALU部分


//两段式
always @(posedge clk or posedge rst)
    if(rst)
        state<=S0;
    else
        state<=next_state;

always @(*)
begin
    case (state)
        S0: next_state=S1;
        S1: next_state=S2;
        S2: next_state=S3;
        S3: next_state=S4;
        S4: next_state=S5;
        S5: next_state=S6;
        S6: next_state=S7;
        default:
            next_state=S7;
    endcase
end
//控制单元
always @(*)
begin
   {m0,m1,m2,m3,m4,m5,en0,en1,en2,en3,done,s0,s1,s2,s3}=15'b0;
   case (state)
        S0: {m1,m2,m3,m4,en0,en1,en2,en3}=8'b0111_1111;//载入数据
        S1,S4,S6://寄存器0和寄存器1中的数据比较，及判断是否交换
            begin
                m0=0;
                m1=1;
                m2=0;
                m5=0;
                en0=cf;
                en1=cf;
            end
        S2,S5://寄存器1和寄存器2中的数据比较，及判断是否交换
            begin
                m0=1;
                m2=0;
                m3=0;
                m5=0;
                en1=~cf;
                en2=~cf;
            end
        S3://寄存器2和寄存器3中的数据比较，及判断是否交换
            begin
                m0=1;
                m3=0;
                m4=0;
                m5=1;
                en2=cf;
                en3=cf;
            end
        S7: //排序完成输出
            begin
                done=1;
                en0=0;
                en1=0;
                en2=0;
                en3=0;
                s0=r3;
                s1=r2;
                s2=r1;
                s3=r0;
            end
    endcase
end

endmodule
