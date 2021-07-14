`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/05/15 22:53:10
// Design Name: 
// Module Name: EDG
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


module EDG(
    input clk,
    input y,
    input rst,
    output p
    );
    parameter S0=2'b00;
    parameter S1=2'b01;
    parameter S2=2'b10;    
    reg [1:0] state=S0,next_state;  
    assign p=(state==S1);   
    always@(posedge clk or posedge rst)
        if(rst)
            state<=S0;
        else
            state<=next_state;  
    always@(*)
    begin
        case(state)
            S0:if(y)
                    next_state=S1;
                else
                    next_state=S0;
            S1:if(y)
                    next_state=S2;
                else
                    next_state=S0;
            S2:if(y)
                    next_state=S2;
                else
                    next_state=S0;
        endcase
    end
endmodule
