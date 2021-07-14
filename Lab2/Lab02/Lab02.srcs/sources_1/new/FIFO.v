`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/05/02 15:58:22
// Design Name: 
// Module Name: FIFO
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


module FIFO(
    input clk,
    input rst,
    input en_in,
    input [7:0] din,
    input en_out,
    output [7:0] dout,
    output reg [4:0] count
    );
    reg [3:0] head,tail;//c1为队头指针，c2为队尾指针
    wire in,out;
    reg en;
    reg [3:0] addr=4'b0;
    reg [1:0] state,next_state;
 
    
    EDG edg1(clk,en_in,rst,in);//输入使能取边沿
    EDG edg2(clk,en_out,rst,out);//输出使能取边沿
    
    RAM1 ram(.clka(clk),.ena(en),.wea(in),.addra(addr),.dina(din),.douta(dout));
       
    always@(posedge clk,posedge rst)
    begin
        if(rst)
            begin
                state<=2'b00;
                count<=5'b0;
                head<=4'b0;
                tail<=4'b0;
                addr<=4'b0;
            end
        else
            state<=next_state;
    end
       
    always@(*)
        begin
            case(state)
            2'b00:
                begin
                    count=count;
                    if((in==1'b1) && ~(count==5'b10000))//输入使能且未满
                        begin
                            addr=tail;
                            en=1'b1;
                            next_state=2'b10;
                        end
                        else    
                            if((out==1'b1) && ~(count==5'b0))//输出使能且非空
                            begin
                                addr=head;
                                en=1'b1;
                                next_state=2'b01;
                            end
                            else
                                begin
                                    addr=4'bX;
                                    next_state=2'b00;
                                    en=1'b0;
                                end
                end
            2'b01://输出
                begin
                    count=count-5'b1;
                    head=head+4'b1;
                    next_state=2'b0;
                end
            2'b10://输入
                begin
                    count=count+5'b1;
                    tail=tail+4'b1;
                    next_state=2'b0;
                end
            default: 
                next_state=2'b00;
            endcase
        end
endmodule
