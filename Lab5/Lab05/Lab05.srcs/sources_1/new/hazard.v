`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/06/01 22:39:07
// Design Name: 
// Module Name: hazard
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


module hazard(
	 input clk,
	 input rst,
	 input [5:0] Op,
	 input [4:0] Rs_ID,
	 input [4:0] Rt_ID, 
	 input [4:0] RegWtaddr_EX,
	 input [4:0] RegWtaddr_MEM,
	 input DMemRead_EX,
	 input DMemRead_MEM,
	 output PCEn,
	 output IF_ID_En,
	 output ID_EX_Flush,
	 output reg    [1:0]   count
    );
	assign ID_EX_Flush = ((((RegWtaddr_EX == Rs_ID) || (RegWtaddr_EX == Rt_ID)) && (DMemRead_EX || Op==6'b000100)) 
	                       || (((RegWtaddr_MEM == Rs_ID) || (RegWtaddr_MEM == Rt_ID)) 
	                       && (DMemRead_MEM || Op==6'b000100)))&&(count!=3);//条件成立则为1，清空
	assign IF_ID_En = ~ID_EX_Flush;//条件成立则为0，保持
	assign PCEn = (~ID_EX_Flush );//条件成立则为0，保持
	always@(posedge clk or posedge rst)
	begin
	   if(rst)
	       count<=0;
	   else    if(((RegWtaddr_EX == Rs_ID) || (RegWtaddr_EX == Rt_ID)) && (Op==6'b000100) && (count!=1) && (count!=2))
	               count<=1;
	   else    if(count==1)
	               count<=2;
       else    if(count==2) 
                   count<=3;
       else    if(count==3)
                   count<=0;
	end
endmodule
