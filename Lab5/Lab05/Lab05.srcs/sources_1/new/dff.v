`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/06/01 22:29:14
// Design Name: 
// Module Name: dff
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


module dff #(parameter WIDTH = 32) ( //Data Flip-Flop 
    input clk,
	input en,
	input rst,
    input [WIDTH-1:0] datain,
    output reg [WIDTH-1:0] dataout
    );
	always@(posedge clk)
	begin
		if(rst)
			dataout <= 0;
		else if(en)
			dataout <= datain;
	end
endmodule
