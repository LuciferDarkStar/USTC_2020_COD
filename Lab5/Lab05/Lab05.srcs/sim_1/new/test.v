`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/06/03 20:58:35
// Design Name: 
// Module Name: test
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


module test;
    reg clk;
    reg [7:0]   sw;
    reg rst;
    reg read;
    top top(.clock(clk),.sw(sw),.btns(rst),.read(read));
    
    always
        #2 clk = ~ clk;
        
    initial
	begin
    #0  clk=0;
    #0  sw=9;
    #0  rst=1;
    #0  read=0;
    #7 rst=0;
    #132 read=1;  
    #10 $finish;
	end
endmodule
