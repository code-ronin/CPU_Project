`timescale 1ns / 1ps

module SignExtender(Imm, IROut, ALUOp
    );
//OUTPUTS----------------------------
	output reg [31:0] Imm;
//INPUTS-----------------------------
	input [31:0] IROut;
	input [5:0] ALUOp;
//OTHER------------------------------
//CODE-------------------------------

//Used for I-type logical/arithmetic instructions
	always @(*) begin
		if (IROut[31:30] == 2'b 10)	//Branch instruction SE
		begin
			if (IROut[15] == 1'b 0) 
				begin
				Imm = {16'b 0000_0000_0000_0000, IROut[15:0]};
				end
				else 
				begin
				Imm = {16'b 1111_1111_1111_1111, IROut[15:0]};
				end
		end
		//ADDI, SUBI, and SLTI need SE
		else if (ALUOp == 6'b 110010)	//ADDI
		begin
			if (IROut[15] == 1'b 0) 
				begin
				Imm = {16'b 0000_0000_0000_0000, IROut[15:0]};
				end
				else 
				begin
				Imm = {16'b 1111_1111_1111_1111, IROut[15:0]};
				end
		end
		else if (ALUOp == 6'b 110011)	//SUBI
		begin
			if (IROut[15] == 1'b 0) 
				begin
				Imm = {16'b 0000_0000_0000_0000, IROut[15:0]};
				end
				else 
				begin
				Imm = {16'b 1111_1111_1111_1111, IROut[15:0]};
				end
		end
		else if (ALUOp == 6'b 110111)	//SLTI
		begin
			if (IROut[15] == 1'b 0) 
				begin
				Imm = {16'b 0000_0000_0000_0000, IROut[15:0]};
				end
				else 
				begin
				Imm = {16'b 1111_1111_1111_1111, IROut[15:0]};
				end
		end
		else	//Do Zero extend for eveyrthing else
		begin
			Imm = {16'b 0000_0000_0000_0000, IROut[15:0]};
		end
	end
endmodule
