`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/05/03 21:03:29
// Design Name: 
// Module Name: EDG_test
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


module EDG_test;
    reg clk;
    reg y;
    reg rst;
    wire p;
    EDG edg(clk,y,rst,p);
    
    always 
		#5 clk = ~ clk;
		
    initial
	begin
	#0 clk = 1'b0;
	#0 rst=1'b0;
	#0 y=1'b0;
	
	#5 y=1'b1;
	
	#50 y=1'b0;
	
	#10 y=1'b1;
	#10 $finish;
	end
endmodule
