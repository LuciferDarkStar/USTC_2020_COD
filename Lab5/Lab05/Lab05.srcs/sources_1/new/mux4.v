`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/06/01 22:31:22
// Design Name: 
// Module Name: mux4
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


module mux4 #(parameter WIDTH = 32)(
    input [1:0] sel,
    input [WIDTH-1:0] d0,
    input [WIDTH-1:0] d1,
	input [WIDTH-1:0] d2,
	input [WIDTH-1:0] d3,
    output reg [WIDTH-1:0] out
    );
	always@(*)
		case(sel)
			2'b00: out=d0;
			2'b01: out=d1;
			2'b10: out=d2;
			2'b11: out=d3;
			default:;
		endcase
endmodule