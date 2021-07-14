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
    parameter S0=3'b000,//����
    parameter S1=3'b001,//x0��x1�Ƚ�
    parameter S2=3'b010,//x1��x2�Ƚ�
    parameter S3=3'b011,//x2��x3�Ƚ�
    parameter S4=3'b100,//x0��x1�Ƚ�
    parameter S5=3'b101,//x1��x2�Ƚ�
    parameter S6=3'b110,//x0��x1�Ƚ�
    parameter S7=3'b111//�������
)
(
    output reg [N-1:0] s0, s1, s2, s3, 	//�������ĸ����ݣ�������
    output reg done, 				//���������־
    input [N-1:0] x0, x1, x2, x3,	//ԭʼ��������
    input clk, rst				//ʱ�ӣ���������Ч������λ���ߵ�ƽ��Ч��
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
    M5(.m(m5),.y(i5),.a(r1),.b(r3));//ѡ��������
    
register
    R0(.clk(clk),.rst(rst),.en(en0),.a(i1),.y(r0)),
    R1(.clk(clk),.rst(rst),.en(en1),.a(i2),.y(r1)),
    R2(.clk(clk),.rst(rst),.en(en2),.a(i3),.y(r2)),
    R3(.clk(clk),.rst(rst),.en(en3),.a(i4),.y(r3));//�Ĵ�������
    
ALU alu(.m(3'b001),.cf(cf),.a(i0),.b(i5));//ALU����


//����ʽ
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
//���Ƶ�Ԫ
always @(*)
begin
   {m0,m1,m2,m3,m4,m5,en0,en1,en2,en3,done,s0,s1,s2,s3}=15'b0;
   case (state)
        S0: {m1,m2,m3,m4,en0,en1,en2,en3}=8'b0111_1111;//��������
        S1,S4,S6://�Ĵ���0�ͼĴ���1�е����ݱȽϣ����ж��Ƿ񽻻�
            begin
                m0=0;
                m1=1;
                m2=0;
                m5=0;
                en0=cf;
                en1=cf;
            end
        S2,S5://�Ĵ���1�ͼĴ���2�е����ݱȽϣ����ж��Ƿ񽻻�
            begin
                m0=1;
                m2=0;
                m3=0;
                m5=0;
                en1=~cf;
                en2=~cf;
            end
        S3://�Ĵ���2�ͼĴ���3�е����ݱȽϣ����ж��Ƿ񽻻�
            begin
                m0=1;
                m3=0;
                m4=0;
                m5=1;
                en2=cf;
                en3=cf;
            end
        S7: //����������
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
