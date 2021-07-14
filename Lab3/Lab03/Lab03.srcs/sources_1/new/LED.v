`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/05/10 11:12:22
// Design Name: 
// Module Name: LED
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


module LED(     
    input [3:0] sw,     
    output reg [7:0] led     
    );          
    always@(*)       
        begin         
        case(sw)             
            4'h0:led = 8'b11000000;             
            4'h1:led = 8'b11111001;             
            4'h2:led = 8'b10100100;             
            4'h3:led = 8'b10110000; 
            4'h4:led = 8'b10011001;                
            4'h5:led = 8'b10010010;             
            4'h6:led = 8'b10000010;             
            4'h7:led = 8'b11111000;             
            4'h8:led = 8'b10000000;             
            4'h9:led = 8'b10010000;             
            4'ha:led = 8'b10001000;             
            4'hb:led = 8'b10000011;             
            4'hc:led = 8'b11000110;             
            4'hd:led = 8'b10100001;             
            4'he:led = 8'b10000110;             
            4'hf:led = 8'b10001110;             
            default: led = 8'b00000000;         
        endcase       
        end 
endmodule
