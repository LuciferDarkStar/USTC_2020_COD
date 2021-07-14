`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/04/22 21:59:04
// Design Name: 
// Module Name: ALU
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


module ALU
    #(parameter WIDTH = 32)
    (
    output reg [WIDTH-1:0] y, 		//������
    output reg zf, 					//���־
    output reg cf, 					//��λ/��λ��־
    output reg of,                 //�����־
    output reg sf, 					//���λ�Ƿ�Ϊ1
    input [WIDTH-1:0] a, b,		//��������
    input [2:0] m						//��������
    );
    always@(*)
        case (m)
            3'b000://��
            begin
                {cf,y}=a+b;
                of=(~a[WIDTH-1]&~b[WIDTH-1]&y[WIDTH-1])|(a[WIDTH-1]&b[WIDTH-1]&~y[WIDTH-1]);//�����־
                sf=y[WIDTH-1];//���ű�־
                zf=~|y;//���־
            end
            
            3'b001://��
            begin
                {cf,y}=a-b;
                of=(~a[WIDTH-1]&b[WIDTH-1]&y[WIDTH-1])|(a[WIDTH-1]&~b[WIDTH-1]&~y[WIDTH-1]);//�����־
                sf=y[WIDTH-1];//���ű�־
                zf=~|y;//���־
            end
            
            3'b010://��
            begin
                cf=1'bx;
                of=1'bx;
                y=a&b;
                sf=y[WIDTH-1];//���ű�־
                zf=~|y;//���־
            end  
            
            3'b011://��
            begin
                cf=1'bx;
                of=1'bx;
                y=a|b;
                sf=y[WIDTH-1];//���ű�־
                zf=~|y;//���־
            end
            
            3'b100://���
            begin
                cf=1'bx;
                of=1'bx;
                y=a^b;
                sf=y[WIDTH-1];//���ű�־
                zf=~|y;//���־
            end    
            
            default:
            begin
                cf=1'bx;
                of=1'bx;
                y=32'bx;
                sf=1'bx;
                zf=1'bx;
            end
        endcase
endmodule
