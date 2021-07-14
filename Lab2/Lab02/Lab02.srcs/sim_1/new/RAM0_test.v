`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/05/02 11:07:37
// Design Name: 
// Module Name: RAM0_test
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


module RAM0_test;
    reg [3 : 0] a;
    reg [7 : 0] d;
    reg clk;
    reg we;
    wire [7 : 0] spo;
    
    RAM0 ram0(a,d,clk,we,spo);
    
    always 
		#5 clk = ~ clk;
		
    initial
	begin
	#0 clk = 1'b0;
	#0 we = 1'b1;
	
	#5 a=1;
	#0 d=1;
	
	#10 a=4;
	#0 d=4;
	
	#10 a=10;
	#0 d=10;
	
	#10 a=15;
	#0 d=15;
	
	#10 a=7;
	#0 d=7;
	
	#10 a=1;
	#0 we=0;
	#10 a=4;
	#10 a=10;
	#10 a=15;
	#10 a=7;
	#10 a=1;
    #20 $finish;
	end
	
endmodule
