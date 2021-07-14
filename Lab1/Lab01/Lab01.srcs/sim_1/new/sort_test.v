`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/04/25 17:15:51
// Design Name: 
// Module Name: sort_test
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


module sort_test;
    reg clk, rst;
    reg [31:0] x0, x1, x2,x3;
    wire [31:0] s0, s1, s2,s3;
    wire done;
    
parameter PERIOD = 10, 	//时钟周期长度
CYCLE = 33;		//时钟个数

    SORT    sort(.s0(s0),.s1(s1),.s2(s2),.s3(s3),.done(done),.x0(x0),.x1(x1),.x2(x2),.x3(x3),.clk(clk),.rst(rst));
    
    initial
    begin
        clk = 0;
        repeat (2 * CYCLE)
        	#(PERIOD/2) clk = ~clk;
        $finish;
    end
    
    initial
    begin
    rst = 1;
    #PERIOD rst = 0;
    
    #(PERIOD*10) rst = 1;
    #PERIOD rst = 0;
    
    #(PERIOD*10) rst = 1;
    #PERIOD rst = 0;    
    end
    
    initial
    begin
    x0 = 3;
    x1 = 5;
    x2 = 7;
    x3=4;
    
    #(PERIOD*10);
    x0 = 10;
    x1 = 8;
    x2 = 15;
    x3=7;

    #(PERIOD*10);
    x0 = 2;
    x1 = 3;
    x2 = 9;
    x3=10;
end
endmodule
