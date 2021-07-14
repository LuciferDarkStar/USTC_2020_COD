`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/05/02 10:35:09
// Design Name: 
// Module Name: register_file_test
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


module register_file_test;
    reg [31:0] WriteData;
	reg [4:0] ReadRegNum1, ReadRegNum2, WriteRegNum;
	reg Clock, RegWrite;
	wire [31:0] ReadData1, ReadData2;

	register_file regf0 (.clk(Clock), .rd0(ReadData1), .rd1(ReadData2), .ra0(ReadRegNum1), .ra1(ReadRegNum2), .wd(WriteData), .wa(WriteRegNum), .we(RegWrite));

	always 
		#5 Clock = ~ Clock;

	initial
	begin
		#0 Clock = 0;
		#0 RegWrite = 1'b0;
		#0 WriteRegNum = 0;

		
		#5 WriteRegNum = 1;
		#0 WriteData = 1;
		#0 RegWrite = 1'b1;
		
		#5 RegWrite = 1'b0;
		
		#5 WriteRegNum = 2;
		#0 WriteData = 2;
        #0 RegWrite = 1'b1;
        
        #5 RegWrite = 1'b0;		

		#5 WriteRegNum = 3;
		#0 WriteData = 3;
		#0 RegWrite = 1'b1;
		

	
	    #5 RegWrite = 1'b0;	
	
		#5 ReadRegNum1 = 1;
		#0 ReadRegNum2 = 2;
		
		#5 ReadRegNum1 = 3;
		#0 ReadRegNum2 = 0;

		#5 $finish;
	end
endmodule
