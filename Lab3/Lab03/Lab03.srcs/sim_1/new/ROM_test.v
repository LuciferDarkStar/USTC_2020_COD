`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/05/07 23:04:00
// Design Name: 
// Module Name: ROM_test
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


module ROM_test;
reg [7 : 0] a;
wire [31 : 0] spo;
IM rom(.a(a),.spo(spo));
initial
	begin
    #0 a=0;
    #5 a=1;
    #5 a=2;
    #5 a=3;
    #5 $finish;
	end
endmodule
