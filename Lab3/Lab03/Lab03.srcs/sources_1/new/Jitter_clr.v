`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/05/10 11:25:04
// Design Name: 
// Module Name: Jitter_clr
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


module Jitter_clr(
    input clk,
    input button,
    output button_clean
    );
parameter jitter_clr_bit=18;

reg [jitter_clr_bit:0] cnt;

always@(posedge clk)
begin
    if(button==0)
        cnt<=0;
    else
        if(cnt<(1<<jitter_clr_bit))
            cnt<=cnt+1;
end

assign button_clean=cnt[jitter_clr_bit];
endmodule
