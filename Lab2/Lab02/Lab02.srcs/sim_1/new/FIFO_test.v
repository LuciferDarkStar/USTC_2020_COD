`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/05/03 20:29:50
// Design Name: 
// Module Name: FIFO_test
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


module FIFO_test;
    reg clk;
    reg rst;
    reg en_in;
    reg [7:0] din;
    reg en_out;
    wire [7:0] dout;
    wire [4:0] count;
    
    FIFO fifo(clk,rst,en_in,din,en_out,dout,count);
    
    always 
		#5 clk = ~ clk;
    
    initial
	begin
	#0 clk = 1'b0;
	#0 en_in=1'b0;
	#0 en_out=1'b0;
	#0 rst=1'b1;
	
	#10 rst=1'b0;
	
    #5 en_in=1'b1;
    #0 din=1;
    #20 en_in=1'b0;
    
    #20 en_in=1'b1;
    #0 din=2;
    #20 en_in=1'b0;
    
    #20 en_in=1'b1;
    #0 din=3;
	#20 en_in=1'b0;
    
    #20 en_in=1'b1;
    #0 din=4;  
    #20 en_in=1'b0;
    
    #20 en_in=1'b1;
    #0 din=5;
    #20 en_in=1'b0;
    
    #20 en_in=1'b1;
    #0 din=6;
    #20 en_in=1'b0;
    
    #20 en_in=1'b1;
    #0 din=7;
    #20 en_in=1'b0;
    
    #20 en_in=1'b1;
    #0 din=8;
    #20 en_in=1'b0;
    
    #20 en_in=1'b1;
    #0 din=9;
    #20 en_in=1'b0;

    #20 en_in=1'b1;
    #0 din=10;
    #20 en_in=1'b0;
    
    #20 en_in=1'b1;
    #0 din=11;
    #20 en_in=1'b0;
    
    #20 en_in=1'b1;
    #0 din=12;
    #20 en_in=1'b0;
    
    #20 en_in=1'b1;
    #0 din=13;
    #20 en_in=1'b0;
    
    #20 en_in=1'b1;
    #0 din=14;
    #20 en_in=1'b0;
    
    #20 en_in=1'b1;
    #0 din=15;
    #20 en_in=1'b0;
    
    #20 en_in=1'b1;
    #0 din=7;
    #20 en_in=1'b0;
    
    #20 en_in=1'b1;
    #0 din=8;
    #20 en_in=1'b0;
        
    #20 en_out=1'b1;
    #20 en_out=1'b0;
    
    #20 en_out=1'b1;
    #20 en_out=1'b0;
    
    #20 en_out=1'b1;
    #20 en_out=1'b0;
    
    #20 en_out=1'b1;
    #20 en_out=1'b0;
    
    #20 en_in=1'b1;
    #0 din=9;
    #20 en_in=1'b0;
    
    #20 en_in=1'b1;
    #0 din=11;
    #20 en_in=1'b0;
    
    #20 en_out=1'b1;
    #20 en_out=1'b0;
    
    #20 en_out=1'b1;
    #20 en_out=1'b0;
    
    #20 en_out=1'b1;
    #20 en_out=1'b0;
    
    #20 en_out=1'b1;
    #20 en_out=1'b0;
    
    #20 en_out=1'b1;
    #20 en_out=1'b0;
    
    #20 en_out=1'b1;
    #20 en_out=1'b0;
    
    #20 en_out=1'b1;
    #20 en_out=1'b0;
    
    #20 en_out=1'b1;
    #20 en_out=1'b0;
    
    #20 en_out=1'b1;
    #20 en_out=1'b0;
    
    #20 en_out=1'b1;
    #20 en_out=1'b0;
    
    #20 en_out=1'b1;
    #20 en_out=1'b0;
    
    #20 en_out=1'b1;
    #20 en_out=1'b0;
    
    #20 en_out=1'b1;
    #20 en_out=1'b0;
    
    #20 en_out=1'b1;
    #20 en_out=1'b0;
    
    #20 en_out=1'b1;
    #20 en_out=1'b0;
        
	#20 $finish;
	end
endmodule
