/*
Inputs:
instruction bits 0-25
a 2 bit control input
Outputs:
64 bit extended immediate

Behavior:
Isolate the immediate in the instruction bits, then sign extend it
by instruction type:

I: 10-21
D: 12-20
B: 0-25
CBZ: 5-23
IW: 5-20

*/

module SignExtender(BusImm, Imm26, Ctrl);
	// ins/outs
	output reg [63:0] BusImm;
	input [25:0] Imm26;
	input [2:0] Ctrl;
	 
	always @(*)
		case (Ctrl)
			0: begin // I. 12 bit immediate, copy first 11, then the 12th 53 times
				BusImm[63:0] <= { { 52{1'b0} }, Imm26[21:10]};	
			end
			1: begin // D. 	9 bit immediate
				BusImm[63:0] <= { {56{Imm26[20]} }, Imm26[19:12]};					
			end
			2: begin // B. 26 bit immediate
				BusImm[63:0] <= { {39{Imm26[25]} }, Imm26[24:0]};					
			end
			3: begin // CB. 19  bit immediate
				BusImm[63:0] <= { {46{Imm26[23]} }, Imm26[22:5]};
			end				
			4: begin // IW. 16  bit immediate
				case (Imm26[22:21])
					0: BusImm[63:0] <= { {48{1'b0} }, Imm26[20:5]};
					1: BusImm[63:0] <= { {48{1'b0} }, Imm26[20:5]} << 16;
					2: BusImm[63:0] <= { {48{1'b0} }, Imm26[20:5]} << 32;
					3: BusImm[63:0] <= { {48{1'b0} }, Imm26[20:5]} << 48;
				endcase	
			end				
		endcase

endmodule
