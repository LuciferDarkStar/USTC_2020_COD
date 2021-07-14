`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/05/02 10:18:16
// Design Name: 
// Module Name: register_file
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


module register_file
#(parameter WIDTH = 32)
(
    input clk,					//时钟（上升沿有效）
    input [4:0] ra0,				//读端口0地址
    output [WIDTH-1:0] rd0, 	//读端口0数据
    input [4:0] ra1, 				//读端口1地址
    output [WIDTH-1:0] rd1, 	//读端口1数据
    input [4:0] wa, 				//写端口地址
    input we,					//写使能，高电平有效
    input [WIDTH-1:0] wd 		//写端口数据
);
reg [4:0] addr_reg;
reg [WIDTH-1:0] mem[0:31];

assign rd0=mem[ra0];//异步读
assign rd1=mem[ra1];

always@(*)
    mem[0]=0;

always@(posedge clk)
begin
    if(we)
        if(~(wa==5'b0))
            mem[wa]<=wd;//同步写
    mem[0]=0;
end
endmodule
