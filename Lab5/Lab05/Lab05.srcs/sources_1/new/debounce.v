`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/06/01 23:02:32
// Design Name: 
// Module Name: debounce
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


module debounce(
	input clk,
    input in,
    output reg out=0
    );
	reg [31:0] cnt=0;
	always@(posedge clk)
		begin
			if(in!=out)
				begin
					cnt=cnt+1;
					
					if(cnt==100000)
					begin
						out=~out;
						cnt=0;
					end
					
				end
			else cnt=0;
			
		end
endmodule

