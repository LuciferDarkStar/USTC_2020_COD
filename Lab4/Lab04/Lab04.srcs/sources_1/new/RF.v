`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/05/14 21:07:06
// Design Name: 
// Module Name: RF
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


module RF
#(parameter WIDTH = 32)
(
    input clk,					//ʱ�ӣ���������Ч��
    input [4:0] ra0,				//���˿�0��ַ
    output [WIDTH-1:0] rd0, 	//���˿�0����
    input [4:0] ra1, 				//���˿�1��ַ
    output [WIDTH-1:0] rd1, 	//���˿�1����
    input [4:0] wa, 				//д�˿ڵ�ַ
    input we,					//дʹ�ܣ��ߵ�ƽ��Ч
    input [WIDTH-1:0] wd 		//д�˿�����
    );
reg [4:0] addr_reg;
reg [WIDTH-1:0] mem[0:31];

assign rd0=mem[ra0];//�첽��
assign rd1=mem[ra1];

always@(*)
    mem[0]=0;

always@(posedge clk)
begin
    if(we)
        if(~(wa==5'b0))
            mem[wa]<=wd;//ͬ��д
    mem[0]=0;
end
endmodule
