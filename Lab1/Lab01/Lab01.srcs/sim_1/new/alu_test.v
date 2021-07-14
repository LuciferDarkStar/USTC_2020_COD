`timescale 1ns / 100ps

module alu_test;
    reg [3:0] a, b;
    reg [2:0] m;
    wire [3:0] y;
    wire zf, cf, of,sf;
    
    parameter PERIOD = 10;
     
    ALU #(4)alu(.a(a), .b(b), .m(m), .y(y), .cf(cf), .of(of), .zf(zf),.sf(sf));
    
    initial begin
        m = 0;      		//ADD
        a = 4'b0011; 
        b = 4'b1100;
        
        #PERIOD;
        a = 4'b1000;
        b = 4'b1101;
        
        #PERIOD;
        a = 4'b0101;
        b = 4'b1001;
        
        #PERIOD;
        a = 4'b1111;
        b = 4'b0001;
                
        #PERIOD m = 1;	//SUB

        #PERIOD;
        a = 4'b0011;
        b = 4'b1110;
        
        #PERIOD;
        a = 4'b1000;
        b = 4'b1101;
        
        #PERIOD;
        a = 4'b0101;
        b = 4'b1001;
        
        #PERIOD;
        a = 4'b0111;
        b = 4'b0111; 

        #PERIOD m = 2;	//AND
        a = 4'b0011;
        b = 4'b0101;
        
        #PERIOD m = 3;	//OR
        a = 4'b0011;
        b = 4'b0101;

        #PERIOD m = 4;	//XOR
        a = 4'b0011;
        b = 4'b0101;
        #PERIOD m = 5;	//other
        a = 4'b0011;
        b = 4'b0101;
        #PERIOD;
        $finish;      
    end
endmodule