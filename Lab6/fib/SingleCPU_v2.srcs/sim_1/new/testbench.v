`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/05/14 12:14:25
// Design Name: 
// Module Name: testbench
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


module testbench(
    );
    reg clk,rst;
    reg Run,Step,F_Write;
    reg [31:0] F_Addr,F;
    SingleCPU CPU(.clk(clk), .rst(rst), .F(F), .F_Addr(F_Addr), .Run(Run), .Step(Step), .F_Write(F_Write));

initial clk = 1;
always #5 clk = ~clk;
initial
    begin
        rst = 1;
        #40 rst = 0;
    end
    
initial
begin
    Run = 0;
    #40 
    Run = 1;
end
/*
initial
begin
    Step = 0;
    #40
    Step = 1;
    #20
    Step = 0;
end
*/
initial
begin
    F_Write = 1;
    #40 F_Write = 0;
end

initial
begin
    F_Write = 1;
    #40 F_Write = 0;
end

initial
begin
    F_Addr = 32'h0000;
    #20 
    F_Addr = 32'h0004;
    #20 
    F_Addr = 32'hzzzz;
end

initial
begin
    F = 32'h0001;
    #20 
    F = 32'h0001;
    #20 
    F = 32'hzzzz;
end
endmodule
