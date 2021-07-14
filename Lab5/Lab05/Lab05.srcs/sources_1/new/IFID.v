`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/06/01 22:32:16
// Design Name: 
// Module Name: IFID
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


module IFID(
    input clk,
	input en,
	input flush,
    input [31:0] PCPlus_in,
	input [31:0] IMemout_in,
    output [31:0] PCPlus_out,
	output [31:0] IMemout_out
    );
	 dff dff1(clk,en,flush,PCPlus_in,PCPlus_out);
	 dff dff2(clk,en,flush,IMemout_in,IMemout_out);
endmodule
