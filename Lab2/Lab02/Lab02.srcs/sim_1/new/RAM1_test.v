`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/05/02 15:32:02
// Design Name: 
// Module Name: RAM1_test
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


module RAM1_test;
    reg clk;
    reg en;
    reg we;
    reg [3:0] a;
    reg [7:0] d;
    wire [7:0] douta;
    
    RAM1 ram1(clk,en,we,a,d,douta);
    
    always 
		#5 clk = ~ clk;
		
    initial
	begin
	#0 clk = 1'b0;
	#0 we = 1'b1;
	#0 en=1'b1;
    #0 d=2;
    #0 a=1;
	
	#5 a=1;
    #7 d=4;
    #1 a=4;
    #7 d=10;
    #3 a=10;
    #5 we=1'b0;
    #3 a=4;
    #8 a=1;
    #10 a=10;
    #20 $finish;
	end
endmodule
