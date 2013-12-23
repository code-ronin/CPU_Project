`timescale 1ns / 1ps

module ALUControl(
	//Outputs
	Operation,
	//Inputs
	Instruction
    );
//OUTPUTS-------------------------------------
	output [3:0] Operation;
//INPUTS--------------------------------------
	input [5:0] Instruction;
//OTHER---------------------------------------
	reg [4:0] Operation;
//CODE----------------------------------------

	//Functions are as follows:
		//00000 = MOV
		//00001 = NOT
		//00010 = ADD
		//00011 = SUB
		//00100 = OR
		//00101 = AND
		//00110 = XOR
		//00111 = SLT
		//01000 = BEQ
		//01001 = BNE
		//01010 = BLT
		//01011 = BLE
		//01100 = LI
		//01101 = LUI
		//01110 = LWI
		//01111 = LW
		//10000 = SWI
		//10001 = SW
		//10010 = JAL
		
	always @ (*) begin
		if (Instruction == 6'b 000000) begin	//NOOP
			Operation = 5'b 00010; //ADD for incrementing PC
		end
		if (Instruction == 6'b 000001) begin	//JUMP
			Operation = 5'b 00010; //ADD to get new address
		end
		if (Instruction == 6'b 000010) begin	//JAL
			Operation = 5'b 00010; //ADD to get new address
		end
		//I-type and R-type logical/arithmetric functions use functions that match their name
		if (Instruction == 6'b 010000) begin	//MOV
			Operation = 5'b 00000;
		end
		if (Instruction == 6'b 010001) begin	//NOT
			Operation = 5'b 00001;
		end	
		if (Instruction == 6'b 010010) begin	//ADD
			Operation = 5'b 00010;
		end	
		if (Instruction == 6'b 010011) begin	//SUB
			Operation = 5'b 00011;
		end	
		if (Instruction == 6'b 010100) begin	//OR
			Operation = 5'b 00100;
		end	
		if (Instruction == 6'b 010101) begin	//AND
			Operation = 5'b 00101;
		end	
		if (Instruction == 6'b 010110) begin	//XOR
			Operation = 5'b 00110;
		end	
		if (Instruction == 6'b 010111) begin	//SLT
			Operation = 5'b 00111;
		end	
		//Functions match instruction name
		if (Instruction == 6'b 100000) begin	//BEQ
			Operation = 5'b 01000;
		end	
		if (Instruction == 6'b 100001) begin	//BNE
			Operation = 5'b 01001;
		end	
		if (Instruction == 6'b 100010) begin	//BLT
			Operation = 5'b 01010;
		end	
		if (Instruction == 6'b 100011) begin	//BLE
			Operation = 5'b 01011;
		end	
		if (Instruction == 6'b 110010) begin	//ADDI
			Operation = 5'b 00010;
		end	
		if (Instruction == 6'b 110011) begin	//SUBI
			Operation = 5'b 00011;
		end	
		if (Instruction == 6'b 110100) begin	//ORI
			Operation = 5'b 00100;
		end	
		if (Instruction == 6'b 110101) begin	//ANDI
			Operation = 5'b 00101;
		end	
		if (Instruction == 6'b 110110) begin	//XORI
			Operation = 5'b 00110;
		end	
		if (Instruction == 6'b 110111) begin	//SLTI
			Operation = 5'b 00111;
		end	
		if (Instruction == 6'b 111001) begin	//LI
			Operation = 5'b 01100;	
		end
		if (Instruction == 6'b 111010) begin	//LUI
			Operation = 5'b 01101;
		end
		if (Instruction == 6'b 111011) begin	//LWI
			Operation = 5'b 01110;
		end
		if (Instruction == 6'b 111101) begin	//LW
			Operation = 5'b 01111;
		end
		if (Instruction == 6'b 111100) begin	//SWI
			Operation = 5'b 10000;
		end
		if (Instruction == 6'b 111110) begin	//SW
			Operation = 5'b 10001;
		end
	end
endmodule
