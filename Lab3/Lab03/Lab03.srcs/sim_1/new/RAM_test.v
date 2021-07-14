`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/05/07 23:04:13
// Design Name: 
// Module Name: RAM_test
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


module RAM_test;
reg [7 : 0] a;
reg [4:0] a1;
reg [31 : 0] d;
reg clk;
reg we,we1;
wire [31 : 0] spo,d1;
DM dm(.a(a),.d(d),.clk(clk),.we(we),.spo(spo));
register_file Registers(.clk(clk),.ra0(a1),.rd0(d1),.ra1(),.rd1(),.wa(a1),.we(we1),.wd(spo));
always 
		#5 clk = ~ clk;
    
initial
	begin
	#0 clk = 1'b0;
	#0 we = 1'b1;
	#0 we1=1'b0;
	#0 a1=1'b0;
	#0 d=1;
	
	#5 a=1;
    #5 d=4;
    #5 a=4;
    #5 d=10;
    #5 a=10;
    #5 we=1'b0;
    #0 we1=1'b1;
    #4 a=4;
    #1 a1=1;
    #7 a=1;
    #0 a1=2;
    #7 a=10;
    #0 a1=3;
    #8 we1=1'b0;
    #6 a1=1;
    #8 a1=2;
    #5 a1=3;
    #10 $finish;
	end
	
endmodule
