`timescale 1ns / 1ps


module RegisterFile(BusA, BusB, BusW, RA, RB, RW, RegWr, Clk);
    //output ports
    output [63:0] BusA;
    output [63:0] BusB;
    //write data
    input [63:0] BusW;
    //write address
    input [4:0] RW;
    //write enable
    input RegWr;
    //clock
    input Clk;
    //read addresses
    input [4:0] RA, RB;


    //internal nets
    reg [63:0] registers [31:0];


    assign  BusA = registers[RA];
    assign  BusB = registers[RB];


    initial begin
	registers[31] = 0;
    end

    /*
    always @(*) begin
        if(RA == 31) #2 BusA = 0;
	else #2 BusA = registers[RA];
	if(RB == 31) #2 BusB = 0;
	else #2 BusB = registers[RB];
    end
    */ 
    always @ (negedge Clk) begin
        if(RegWr && RW != 31)
            registers[RW] <= #3 BusW;
    end
endmodule
