`timescale 1ns / 1ps

module Control(
	//Outputs
	IorD,
	MemWrite,
	MemtoReg,
	PCSource,
	ALUOp,
	ALUSrcB,
	ALUSrcA,
	RegWrite,
	state,
	next_state,
	//Inputs
	Instruction, clk
    );
//INPUTS------------------------------------
	input 	[5:0] Instruction;
	input		clk;
//OUTPUTS-----------------------------------
	output reg 	IorD;
	output reg	MemWrite;			//Write to IR or not
	output reg	MemtoReg;			//Data written to IR is from Memory or ALU
	//output reg	IRWrite;				//Write to Instruction Register
	output reg	[1:0]	PCSource;	//Where PC gets incremented (+4, branch, or jump)
	output reg	[5:0]	ALUOp;		//First 2 MSBs + four bits for unqiue operation name
	output reg	[1:0] ALUSrcB;
	output reg	ALUSrcA;
	output reg	RegWrite;
	output [3:0] state;
//OTHER-------------------------------------
	reg[3:0] state;
	output reg [3:0] next_state;
//CODE--------------------------------------
	initial begin
			ALUSrcA	= 0;
			ALUSrcB 	= 2'b 01;
			IorD 		= 1'b 0;
			ALUOp 	= 6'b 000000;
			PCSource = 2'b 11;
			next_state = 4'd 1;
			MemWrite = 1'b 0;
	end
	always @ (posedge clk) begin
		state = next_state;
	end	
//----General Control Description---------------------------------
	/*
		At 'finish', increment PC by whatever it needs
		
		State 0 = IF
		State 1 = ID and NOOP finish
		State 2 = JUMP finish
		State 3 = Branch finish
		State 4 = R-type WB
		State 5 = I-type logical/arithmetic WB
		State 6 = R/I logical/arithmetic finish
		State 7 = Load Immediate MEM 
		State 8 = Load Immediate finish
		State 9 = Load Word Mem
		State 10 = Load word finish
		State 11 = Store Word MEM
		State 12 = Store Word finish
		State 13 = JAL finish
	*/
//State 0--------------------------> go to state 1
	always @(state) begin
		if (state == 4'd 0) 
		begin
			RegWrite = 1'b 0;
			MemWrite = 1'b 0;
			ALUSrcA	= 1;
			ALUSrcB 	= 2'b 00;
			PCSource = 2'b 11;
			next_state = 4'd 1;
		end
//State 1--------------------------> go to state 0,2,3,4,5,7,9,11
		if (state == 4'd 1)
		begin
		PCSource = 2'b 11;
		MemWrite = 1'b 0;
			if (Instruction == 6'b 000000)begin //NOOP
				ALUSrcA	= 0;
				ALUSrcB 	= 2'b 01;
				ALUOp = 6'b 000000;
				PCSource = 2'b 00;
				next_state = 4'd 0;
			end
			else if (Instruction == 6'b 000001)begin //JUMP
				next_state = 4'd 2;
			end
			else if (Instruction == 6'b 000010) begin //JAL
				MemtoReg = 1'b 0;
				ALUSrcA	= 0;
				ALUSrcB 	= 2'b 01;
				ALUOp = 6'b 00000;
				PCSource = 2'b 11;
				next_state = 4'd 13;
			end
			//R-type
			else if (Instruction == 6'b 010000)begin //MOV
				ALUSrcA 	 = 1'b 1;
				ALUSrcB 	 = 2'b 00;
				ALUOp = 6'b 010000;
				next_state  = 4'd 4;
			end
			else if (Instruction == 6'b 010001)begin //NOT
				ALUSrcA 	 = 1'b 1;
				ALUSrcB 	 = 2'b 00;
				ALUOp = 6'b 010001;
				next_state  = 4'd 4;
			end
			else if (Instruction == 6'b 010010)begin //ADD
				ALUSrcA 	 = 1'b 1;
				ALUSrcB 	 = 2'b 00;
				ALUOp = 6'b 010010;
				next_state  = 4'd 4;
			end
			else if (Instruction== 6'b 010011)begin //SUB
				ALUSrcA 	 = 1'b 1;
				ALUSrcB 	 = 2'b 00;
				ALUOp = 6'b 010011;
				next_state  = 4'd 4;
			end
			else if (Instruction == 6'b 010100)begin //OR
				ALUSrcA 	 = 1'b 1;
				ALUSrcB 	 = 2'b 00;
				ALUOp = 6'b 010100;
				next_state  = 4'd 4;
			end
			else if (Instruction == 6'b 010101)begin //AND
				ALUSrcA 	 = 1'b 1;
				ALUSrcB 	 = 2'b 00;
				ALUOp = 6'b 010101;
				next_state  = 4'd 4;
			end
			else if (Instruction == 6'b 010110)begin //XOR
				ALUSrcA 	 = 1'b 1;
				ALUSrcB 	 = 2'b 00;
				ALUOp = 6'b 010110;
				next_state  = 4'd 4;
			end
			else if (Instruction == 6'b 010111)begin //SLT
				ALUSrcA 	 = 1'b 1;
				ALUSrcB 	 = 2'b 00;
				ALUOp = 6'b 010111;
				next_state  = 4'd 4;
			end
			//Branch
			else if (Instruction == 6'b 100000)begin //BEQ
				ALUSrcA 	 = 1'b 1;
				ALUSrcB 	 = 2'b 00;
				ALUOp = 6'b 100000;
				next_state  = 4'd 3;
			end
			else if (Instruction == 6'b 100001)begin //BNE
				ALUSrcA 	 = 1'b 1;
				ALUSrcB 	 = 2'b 00;
				ALUOp = 6'b 100001;
				next_state  = 4'd 3;
			end
			else if (Instruction == 6'b 100010)begin //BLT
				ALUSrcA 	 = 1'b 1;
				ALUSrcB 	 = 2'b 00;
				ALUOp = 6'b 100010;
				next_state  = 4'd 3;
			end
			else if (Instruction == 6'b 100011)begin //BLE
				ALUSrcA 	 = 1'b 1;
				ALUSrcB 	 = 2'b 00;
				ALUOp = 6'b 100011;
				next_state  = 4'd 3;
			end
			//I-type logical
			else if (Instruction == 6'b 110010)begin //ADDI
				ALUSrcA 	 = 1'b 1;
				ALUSrcB 	 = 2'b 10;
				ALUOp = 6'b 110010;
				next_state  = 4'd 5;
			end
			else if (Instruction == 6'b 110011)begin //SUBI
				ALUSrcA 	 = 1'b 1;
				ALUSrcB 	 = 2'b 10;
				ALUOp = 6'b 110011;
				next_state  = 4'd 5;
			end
			else if (Instruction == 6'b 110100)begin //ORI
				ALUSrcA 	 = 1'b 1;
				ALUSrcB 	 = 2'b 10;
				ALUOp = 6'b 110100;
				next_state  = 4'd 5;
			end
			else if (Instruction == 6'b 110101)begin //ANDI
				ALUSrcA 	 = 1'b 1;
				ALUSrcB 	 = 2'b 10;
				ALUOp = 6'b 110101;
				next_state  = 4'd 5;
			end
			else if (Instruction == 6'b 110110)begin //XORI
				ALUSrcA 	 = 1'b 1;
				ALUSrcB 	 = 2'b 10;
				ALUOp = 6'b 110110;
				next_state  = 4'd 5;
			end
			else if (Instruction == 6'b 110111)begin //SLTI
				ALUSrcA 	 = 1'b 1;
				ALUSrcB 	 = 2'b 10;
				ALUOp = 6'b 110111;
				next_state  = 4'd 5;
			end
			//Load/stores
			else if (Instruction == 6'b 111001)begin //LI
				ALUSrcA = 1'b 1;
				ALUSrcB 	 = 2'b 10;
				ALUOp = 6'b 111001;
				next_state  = 4'd 7;
			end
			else if (Instruction == 6'b 111010)begin //LUI
				ALUSrcA = 1'b 1;
				ALUSrcB 	 = 2'b 10;
				ALUOp = 6'b 111010;
				next_state  = 4'd 7;
			end
			else if (Instruction == 6'b 111011)begin //LWI
				ALUSrcB 	 = 2'b 10;
				ALUOp = 6'b 111011;
				IorD = 1'b 1;
				next_state  = 4'd 9;
			end
			else if (Instruction == 6'b 111101) begin //LW
				ALUSrcB = 2'b 00;
				ALUOp = 6'b 111101;
				next_state = 4'd 9;
			end
			else if (Instruction == 6'b 111100)begin //SWI
				ALUSrcA= 1'b 1;
				IorD = 1'b 1;
				ALUOp = 6'b 111100;
				next_state  = 4'd 11;
			end
			else if (Instruction == 6'b 111110) begin //SW
				ALUSrcA= 1'b 1;
				ALUSrcB= 2'b 10;
				IorD = 1'b 1;
				ALUOp = 6'b 111110;
				next_state = 4'd 11;
			end
			else
			begin
				next_state  = 4'd 0;
			end
		end
//State 2 (JUMP Finish)----------------> go to state 0
		if (state == 4'd 2)
		begin
			PCSource  = 2'b 10;
			ALUSrcA 	 = 1'b 0;
			ALUSrcB 	 = 2'b 01;
			ALUOp		= 6'b 000001;
			//PCWrite 		 = 1'b 1
			next_state 	 = 4'd 0;
		end
//State 3 (I-type Branching Finish)------> go to state 0
		if (state == 4'd 3)
		begin
			PCSource  = 2'b 01;
			ALUSrcA 	 = 1'b 0;
			ALUOp  = 6'b 000000;
			next_state  = 4'd 0;
		end
//State 4 (R-type instruction WB)----> go to state 6
		if (state == 4'd 4)
		begin
			RegWrite = 1'b 1;
			MemtoReg = 1'b 0;
			next_state  = 4'd 6;
			PCSource  = 2'b 11;
		end
//State 5 (I-type logical/arithmetic WB) --> go to state 6
		if (state == 4'd 5)
		begin
			MemtoReg = 1'b 0;
			RegWrite = 1'b 1;
			PCSource  = 2'b 11;
			next_state  = 4'd 6;
		end
//State 6 (I/R-type logical/aritmetic finish)-----> go to state 0
		if (state == 4'd 6)
		begin
			ALUSrcA	 = 0;
			ALUSrcB 	 = 2'b 01;
			ALUOp = 6'b 000000;
			RegWrite =	1'b 1;
			MemtoReg = 1'b 0;
			PCSource  = 2'b 00;
			next_state = 4'd 0;
		end
//State 7 (Load Immediate MEM)------->go to state 8
		if (state == 4'd 7)
		begin
			RegWrite = 1'b 1;
			MemtoReg = 1'b 0;
			PCSource = 2'b 11;
			next_state = 4'd 8;
		end
//State 8 (Load Immediates finish)--------> go to state 0
		if (state == 4'd 8)
		begin
			RegWrite = 1'b 0;
			ALUSrcA	 = 0;
			ALUSrcB	 = 2'b 01;
			PCSource  = 2'b 00;
			ALUOp = 6'b 000000;
			next_state = 4'd 0;
		end
//State 9 (Load word MEM)------> go to state 10
		if (state == 4'd 9)
		begin
			PCSource = 2'b 11;
			MemtoReg = 1'b 1;
			RegWrite = 1'b 1;
			next_state = 4'd 10;
		end
//State 10 (Load word finish)------> go to state 0
		if (state == 4'd 10)
		begin
			RegWrite = 1'b 0;
			PCSource = 2'b 00;
			ALUSrcA	 = 0;
			ALUSrcB 	 = 2'b 01;
			ALUOp = 6'b 000000;
			next_state = 4'd 0;
		end
//State 11 (Store word MEM)----->go to state 12
		if (state == 4'd 11)
		begin
			PCSource = 2'b 11;
			MemWrite = 1'b 1;
			next_state = 4'd 12;
		end
//State 12 (store word finish)----->go to state 0
		if (state == 4'd 12)
		begin
			PCSource = 2'b 00;
			ALUSrcA	 = 0;
			MemWrite = 1'b 0;
			ALUSrcB 	 = 2'b 01;
			ALUOp = 6'b 000000;
			next_state = 4'd 0;
		end
//State 13 (JAL finish)---------> go to state 0
		if (state == 4'd 13)
		begin
			RegWrite = 1'b 1;
			PCSource  = 2'b 10;
			ALUSrcA 	 = 1'b 0;
			ALUSrcB 	 = 2'b 01;
			ALUOp		= 6'b 000001;
			next_state 	 = 4'd 0;
		end
end
endmodule

