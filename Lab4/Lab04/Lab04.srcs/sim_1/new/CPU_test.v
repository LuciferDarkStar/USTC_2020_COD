`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/05/15 21:08:21
// Design Name: 
// Module Name: CPU_test
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


module CPU_test;
reg rst;
reg clk;
reg read;
reg [8:0]   m_rf_addr;
CPU cpu(rst,clk,read,m_rf_addr);
always 
    #2 clk = ~ clk;
initial
begin
#0  clk=0;
#0  rst=1'b1;
#0  read=1'b0;
#0  m_rf_addr=2;
#5  rst=1'b0;
#267 read=1'b1;
#10 $finish;
end	
endmodule
