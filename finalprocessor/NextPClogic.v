module NextPClogic(NextPC, CurrentPC, SignExtImm64, Branch, ALUZero, Uncondbranch); 
	input [63:0] CurrentPC, SignExtImm64;
	input Branch, ALUZero, Uncondbranch; 
	output reg [63:0] NextPC; //made a reg so I can do behavioral stuff

	/* write your code here */ 

	wire doBranch; //if this is 1, we branch. if it's 0, we don't branch
	wire [63:0] shiftedImm; //the offset, shifted so we're counting by 4s (1 instruction = 4 bytes)

	assign doBranch =  Uncondbranch | (ALUZero & Branch); //this'll need to be expanded if CBNZ instructions are added
	assign shiftedImm = SignExtImm64 << 2;

	always @(*) begin
		if(doBranch) NextPC = CurrentPC + shiftedImm; //not sure if the 64'h is necessary
		else NextPC = CurrentPC + 4;
	end


endmodule
