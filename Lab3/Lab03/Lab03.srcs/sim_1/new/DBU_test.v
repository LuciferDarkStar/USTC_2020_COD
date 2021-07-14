`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/05/10 21:06:56
// Design Name: 
// Module Name: DBU_test
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


module DBU_test;
    reg     succ;
    reg     clk;
    reg     rst;
    reg     read;
    reg     step;
    reg     [2:0] sel;
    reg     m_rf;
    reg     inc;
    reg     dec;
    wire    [15:0] led;
    wire    [7:0]  an;//数码管片选
    wire    [31:0]  seg;//8个八段数码管
    DBU dbu(.succ(succ),.rst(rst),.clk(clk),.read(read),.step(step),
            .sel(sel),.m_rf(m_rf),.inc(inc),.dec(dec),.led(led),.an(an),.seg(seg));
    always 
		#2 clk = ~ clk;	
    initial
	begin
	#0  clk=0;
    #0  succ=1'b1;
	#0  step=0;
	#0  rst=1'b1;
	#0  read=1'b0;
	#0  sel=0;
	#0  m_rf=1;
	#0  inc=0;
	#0  dec=0;
	#5  rst=1'b0;
	#70 read=1'b1;
	#0  inc=1'b1;
	#5  inc=1'b0;
	#5  inc=1'b1;
	#10 $finish;
	end
endmodule
