`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/06/01 22:52:27
// Design Name: 
// Module Name: top
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


module top(
    input   clock,
    input   [7:0] sw,
    output  [7:0] seg7,
    output  [7:0] an,
    output  Led,
	input   btns,//rst
	input   read
    );
    wire clk;
    assign  clk=(read==0)?clock:1'b0;
//_��׺��ʾ���ź����ڵ���ˮ��
	wire ALUSrcASel_ID;
	wire ALUSrcASel_EX;
	wire [1:0] ALUSrcBSel_ID;//alu B��regout2��imm֮��ѡ��
	wire [1:0] ALUSrcBSel_EX;
	wire [31:0] ALUSrcA_EX;
	wire [31:0] ALUSrcB_EX;
	wire [4:0] ALUControl_ID;
	wire [4:0] ALUControl_EX;
	wire [31:0] ALUResult_EX;
	wire [31:0] ALUResult_MEM;
	wire [31:0] ALUResult_WB;

	wire [1:0] RsCMPZero;
	wire [1:0] RsCMPRt;

	wire [31:0] IMMSignExtended_ID;
	wire [31:0] IMMSignExtended_EX;
	wire [31:0] IMMZeroExtended_ID;
	wire [31:0] IMMZeroExtended_EX;	
	wire [31:0] ShamtZeroExtended_ID;
	wire [31:0] ShamtZeroExtended_EX;	

	wire [1:0] RegRdout1Sel_Forward_EX;//��·��Ԫ������ѡ���ź�
	wire [1:0] RegRdout2Sel_Forward_EX;
	wire [31:0] RegRdout1_Forward_EX;//��·����
	wire [31:0] RegRdout2_Forward_EX;

	wire [4:0] RegRdaddr1_ID;
	wire [31:0] RegRdout1_ID;
	wire [31:0] RegRdout1_EX;
	wire [4:0] RegRdaddr2_ID;
	wire [31:0] RegRdout2_ID;
	wire [31:0] RegRdout2_EX;
	wire [4:0] RegWtaddr_ID;
	wire [4:0] RegWtaddr_EX;	
	wire [4:0] RegWtaddr_MEM;
	wire [4:0] RegWtaddr_WB;
	wire [31:0] RegWtin_WB;
	wire RegWrite_ID;
	wire RegWrite_EX;
	wire RegWrite_MEM;
	wire RegWrite_WB;
	wire RegDst_ID;
	wire RegDst_EX;

	wire [31:0] IMemaddr;
	wire [31:0] IMemout;

	wire [31:0] DMemaddr_MEM;
	wire [31:0] DMemin_MEM;
	wire DMemRead_MEM;
	wire [31:0] DMemout_MEM;
	wire [31:0] DMemout_WB;
	wire DMemWrite_MEM;
	wire DMemtoReg_EX;
	wire DMemtoReg_MEM;
	wire DMemtoReg_WB;
	wire DMemRead_ID;
	wire DMemWrite_ID;
	wire DMemtoReg_ID;
	wire DMemRead_EX;
	wire DMemWrite_EX;

	wire [31:0] PC;
	wire [31:0] PCPlus_IF;
	wire [31:0] PCPlus_ID;
	wire [31:0] PCPlus_EX;
	wire [31:0] EPC;
	wire [31:0] nextPC;
	wire PCEn;
	wire [1:0] PCSrc_ID;//Control����ģ�0:+4,1:Branch,2:J
	wire IF_ID_En;
	wire IF_ID_Flush;
	wire ID_EX_Flush;

	wire [31:0] PCJump_ID;
	wire [31:0] PCJR_ID;
	wire [31:0] PCBranch_ID;

	wire [31:0] Instr;	
	wire [5:0] Funct;
	wire [4:0] Shamt;
	wire [15:0] IMM16;
	wire [4:0] Rd;
	wire [4:0] Rt;
	wire [4:0] Rs;
	wire [5:0] Op;
	wire [4:0] Rt_EX;//Ϊ����·�ж�
	wire [4:0] Rs_EX;//Ϊ����·�ж�

	wire [25:0] JumpIMM;
	wire [31:0] IMMSignExtendedShiftLeft2;
	wire btns_d;
	//debounce	debounce(clk,btns,btns_d);//�м�ȥ����

	//reg rst;
	//assign Led = rst;
	//always @(posedge btns_d) rst=~rst;
    wire rst;
    wire    [1:0]   count;
    assign rst=btns;

	mux4 MUXPC(
		.sel(PCSrc_ID),
		.d0(PCPlus_IF),//+4ֱ����IF��
		.d1(PCBranch_ID),
		.d2(PCJump_ID),
		.d3(PCJR_ID),
		.out(nextPC)
	);

	dff DFFPC(
		.clk(~clk),
		.en(PCEn),
		.rst(rst),
		.datain(nextPC),
		.dataout(PC)
	);	

	alu ALUPCPlus(PC,4,5'd01,PCPlus_IF);

	assign IMemaddr = PC >> 2;//>>2����Ϊ����IMem��ÿ����ַ�洢4�ֽڣ���ʵ���ϵģ�һ��ַһ�ֽڣ���һ��
	IMem IMem(.a(IMemaddr),.spo(IMemout));//�����ض�ָ��

	//======================IFID========================

	IFID IFID(
		.clk(~clk),
		.en(IF_ID_En),
		.flush((IF_ID_Flush  ) || rst),
		.PCPlus_in(PCPlus_IF),
		.IMemout_in(IMemout),
		.PCPlus_out(PCPlus_ID),
		.IMemout_out(Instr)
	);

	//=======================ID==========================

	assign JumpIMM = Instr[25:0];
	assign Funct = Instr[5:0];
	assign Shamt = Instr[10:6];
	assign IMM16 = Instr[15:0];
	assign Rd = Instr[15:11];
	assign Rt = Instr[20:16];
	assign Rs = Instr[25:21];
	assign Op = Instr[31:26];

	//*******Control*******

	control control(
		//in
		.clk(clk),
		.rst(rst),
		.Op(Op),
		.Rt(Rt),
		.Funct(Funct),
		.RsCMPRt(RsCMPRt),
		.RsCMPZero(RsCMPZero),
		//out
		.PCSrc(PCSrc_ID), 
		//ID
		.RegDst(RegDst_ID),
		//EX
		.ALUSrcASel(ALUSrcASel_ID),
		.ALUSrcBSel(ALUSrcBSel_ID), 
		.ALUControl(ALUControl_ID),
		//MEM
		.DMemRead(DMemRead_ID),
		.DMemWrite(DMemWrite_ID),
		//WB
		.DMemtoReg(DMemtoReg_ID),
		.RegWrite(RegWrite_ID)
	);
	//*******Control*******
	
	assign RegRdaddr2_ID = Rt;
	mux #(5) MUXRegWtaddr(RegDst_ID,Rt,Rd,RegWtaddr_ID);

	assign ShamtZeroExtended_ID = {{27{1'b0}},Shamt};
	assign IMMSignExtended_ID = {{16{IMM16[15]}},IMM16};
	assign IMMZeroExtended_ID = {{16{1'b0}},IMM16};
	assign IMMSignExtendedShiftLeft2 = IMMSignExtended_ID << 2;
	alu BranchALU(PCPlus_ID,IMMSignExtendedShiftLeft2,5'd01,PCBranch_ID);
	assign PCJump_ID = {{PCPlus_ID[31:28]},{{2'b00,JumpIMM}<<2}};
	assign PCJR_ID = RegRdout1_ID;
	assign IF_ID_Flush = (PCSrc_ID == 2'b00)?1'b0:(PCSrc_ID == 2'b10)?1'b1:(count==3)?1'b1:1'b0;//����ת�����IF_ID�Ĵ���
	assign RegRdaddr1_ID = (read==1'b0)?(Rs):sw;
	regfile regfile(clk,~rst,RegRdaddr1_ID,RegRdout1_ID,RegRdaddr2_ID,RegRdout2_ID,RegWtaddr_WB,RegWtin_WB,RegWrite_WB);

	compare compare1(RegRdout1_ID,RegRdout2_ID,RsCMPRt);//for beq,bne
	hazard hazard(clk,rst,Op,Rs,Rt,RegWtaddr_EX,RegWtaddr_MEM,DMemRead_EX,DMemRead_MEM,PCEn,IF_ID_En,ID_EX_Flush,count);

	//======================IDEX=========================

	IDEX IDEX(
		.clk(~clk),
		.en(1'b1),	
		.flush(ID_EX_Flush || rst),
		.PCPlus_in(PCPlus_ID),
		.RegRdout1_in(RegRdout1_ID),
		.RegRdout2_in(RegRdout2_ID),
		.IMMSignExtended_in(IMMSignExtended_ID),
		.IMMZeroExtended_in(IMMZeroExtended_ID),
		.ShamtZeroExtended_in(ShamtZeroExtended_ID),
		.Rs_in(Rs),
		.Rt_in(Rt),
		.RegWtaddr_in(RegWtaddr_ID),
		.PCPlus_out(PCPlus_EX),
		.RegRdout1_out(RegRdout1_EX),
		.RegRdout2_out(RegRdout2_EX),
		.IMMSignExtended_out(IMMSignExtended_EX),
		.IMMZeroExtended_out(IMMZeroExtended_EX),
		.ShamtZeroExtended_out(ShamtZeroExtended_EX),
		.Rs_out(Rs_EX),
		.Rt_out(Rt_EX),
		.RegWtaddr_out(RegWtaddr_EX),
		.RegDst_in(RegDst_ID),
		.ALUSrcASel_in(ALUSrcASel_ID),
		.ALUSrcBSel_in(ALUSrcBSel_ID), 
		.ALUControl_in(ALUControl_ID),
		.DMemRead_in(DMemRead_ID),
		.DMemWrite_in(DMemWrite_ID),
		.DMemtoReg_in(DMemtoReg_ID),
		.RegWrite_in(RegWrite_ID),
		.RegDst_out(RegDst_EX),
		.ALUSrcASel_out(ALUSrcASel_EX),
		.ALUSrcBSel_out(ALUSrcBSel_EX), 
		.ALUControl_out(ALUControl_EX),
		.DMemRead_out(DMemRead_EX),
		.DMemWrite_out(DMemWrite_EX),
		.DMemtoReg_out(DMemtoReg_EX),
		.RegWrite_out(RegWrite_EX)
	);

	//========================EX=========================

	forward forward(Rs_EX,Rt_EX,RegWrite_MEM,RegWrite_WB,RegWtaddr_MEM,RegWtaddr_WB,RegRdout1Sel_Forward_EX,RegRdout2Sel_Forward_EX);
	mux4 MUXRegRdout1FW(RegRdout1Sel_Forward_EX,RegRdout1_EX,RegWtin_WB,ALUResult_MEM,0,RegRdout1_Forward_EX);//forward
	mux4 MUXRegRdout2FW(RegRdout2Sel_Forward_EX,RegRdout2_EX,RegWtin_WB,ALUResult_MEM,0,RegRdout2_Forward_EX);//forward
	mux MUXALUSrcA(ALUSrcASel_EX,RegRdout1_Forward_EX,ShamtZeroExtended_EX,ALUSrcA_EX);
	mux4 MUXALUSrcB(ALUSrcBSel_EX,RegRdout2_Forward_EX,IMMSignExtended_EX,IMMZeroExtended_EX,0,ALUSrcB_EX);
	alu alu(ALUSrcA_EX,ALUSrcB_EX,ALUControl_EX,ALUResult_EX);

	//======================EXMEM========================

	EXMEM EXMEM(
		.clk(~clk),
		.en(1'b1),
		.flush(rst),
		.ALUResult_in(ALUResult_EX),
		.DMemin_in(RegRdout2_Forward_EX),
		.RegWtaddr_in(RegWtaddr_EX),
		.ALUResult_out(ALUResult_MEM),
		.DMemin_out(DMemin_MEM),
		.RegWtaddr_out(RegWtaddr_MEM),
		.DMemRead_in(DMemRead_EX),
		.DMemWrite_in(DMemWrite_EX),
		.DMemtoReg_in(DMemtoReg_EX),
		.RegWrite_in(RegWrite_EX),
		.DMemRead_out(DMemRead_MEM),
		.DMemWrite_out(DMemWrite_MEM),
		.DMemtoReg_out(DMemtoReg_MEM),
		.RegWrite_out(RegWrite_MEM)
	);

	//=======================MEM=========================	

	assign DMemaddr_MEM = (read==1'b0)?(ALUResult_MEM>>2):sw;
	DMem DMem(.clk(clk),.we(DMemWrite_MEM),.a(DMemaddr_MEM ),.d(DMemin_MEM),.spo(DMemout_MEM));	

	//======================MEMWB========================

	MEMWB MEMWB(
		.clk(~clk),
		.en(1'b1),
		.flush(rst),
		.ALUResult_in(ALUResult_MEM),
		.DMemout_in(DMemout_MEM),
		.RegWtaddr_in(RegWtaddr_MEM),
		.ALUResult_out(ALUResult_WB),
		.DMemout_out(DMemout_WB),
		.RegWtaddr_out(RegWtaddr_WB),
		.DMemtoReg_in(DMemtoReg_MEM),
		.RegWrite_in(RegWrite_MEM),
		.DMemtoReg_out(DMemtoReg_WB),
		.RegWrite_out(RegWrite_WB)
	);
	//========================WB=========================
	mux MUXDMemtoReg(DMemtoReg_WB,ALUResult_WB,DMemout_WB,RegWtin_WB);
endmodule
