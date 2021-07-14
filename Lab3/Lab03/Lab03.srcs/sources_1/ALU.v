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
    output reg [WIDTH-1:0] y, 		//运算结果
    output reg zf, 					//零标志
    output reg cf, 					//进位/借位标志
    output reg of,                 //溢出标志
    output reg sf, 					//最高位是否为1
    input [WIDTH-1:0] a, b,		//两操作数
    input [2:0] m						//操作类型
    );
    always@(*)
        case (m)
            3'b000://加
            begin
                {cf,y}=a+b;
                of=(~a[WIDTH-1]&~b[WIDTH-1]&y[WIDTH-1])|(a[WIDTH-1]&b[WIDTH-1]&~y[WIDTH-1]);//溢出标志
                sf=y[WIDTH-1];//符号标志
                zf=~|y;//零标志
            end
            
            3'b001://减
            begin
                {cf,y}=a-b;
                of=(~a[WIDTH-1]&b[WIDTH-1]&y[WIDTH-1])|(a[WIDTH-1]&~b[WIDTH-1]&~y[WIDTH-1]);//溢出标志
                sf=y[WIDTH-1];//符号标志
                zf=~|y;//零标志
            end
            
            3'b010://与
            begin
                cf=1'bx;
                of=1'bx;
                y=a&b;
                sf=y[WIDTH-1];//符号标志
                zf=~|y;//零标志
            end  
            
            3'b011://或
            begin
                cf=1'bx;
                of=1'bx;
                y=a|b;
                sf=y[WIDTH-1];//符号标志
                zf=~|y;//零标志
            end
            
            3'b100://异或
            begin
                cf=1'bx;
                of=1'bx;
                y=a^b;
                sf=y[WIDTH-1];//符号标志
                zf=~|y;//零标志
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
