`timescale 1ns / 1ps

//This does all the calculations
module MainALU(
	//Outputs
	ALUResult,
	//Inputs
	DataA, DataB, Operation, IROut, Imm
    );
	 
//OUTPUTS------------------------
	output [31:0] ALUResult;
//INPUTS-------------------------
	input [31:0] DataA, DataB, IROut, Imm;
	input	[4:0] Operation;
//OTHER--------------------------
	reg [31:0] ALUResult;
//CODE---------------------------
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

	always @ (Operation, DataA, DataB) begin
		//MOV
		if (Operation == 5'b 00000) begin	
			ALUResult = DataA;
		end
		//NOT
		if (Operation == 5'b 00001) begin
			ALUResult = ~(DataA);
		end
		//ADD
		if (Operation == 5'b 00010) begin
			ALUResult = (DataA+DataB);			
		end
		//SUB
		if (Operation == 5'b 00011) begin
			ALUResult = (DataA-DataB);
		end
		//OR
		if (Operation == 5'b 00100) begin
			ALUResult = (DataA|DataB);
		end
		//AND
		if (Operation ==  5'b 00101) begin
			ALUResult = (DataA&DataB);
		end
		//XOR
		if (Operation == 5'b 00110) begin
			ALUResult = (DataA^DataB);
		end
		//SLT
		if (Operation == 5'b 00111) begin
			if (DataA[31] == 1'b 1)begin //for a negative A
				if (DataB[31] == 1'b 0) begin //Neg A and Pos B (cleraly B is bigger than A)
					ALUResult = 32'b 1;
				end
				else if (DataA<DataB)begin //Neg A and Neg B (unsigned, B is bigger, and signed, it's less negative e.g 10000(-16) vs 11111(-1))
					ALUResult = 32'b 1;
					end
				else
					ALUResult = 32'b 0;
			end
			else begin 						//for a positive A
				if (DataB[31] == 1'b 1) begin //Pos A and Neg B (cleraly A is greater than B)
					ALUResult = 32'b 0;
				end
				else if (DataA<DataB) begin	//Pos A and Pos B (unsigned, this test works)
					ALUResult = 32'b 1;
				end
				else
					ALUResult = 32'b 0;
			end
		end
		//BEQ
		if (Operation == 5'b 01000) begin	
			if (DataA==DataB)
				ALUResult = Imm;
			else
				ALUResult = 32'b 1;
		end
		//BNE
		if (Operation == 5'b 01001) begin	
			if (DataA!=DataB)
				ALUResult = Imm;
			else
				ALUResult = 32'b 1;
		end
		//BLT
		if (Operation == 5'b 01010) begin	
			if (DataA<DataB) 
				ALUResult = Imm;
			else
				ALUResult = 32'b 1;
		end
		//BLE
		if (Operation == 5'b 01011) begin	
			if (DataA<=DataB)
				ALUResult = Imm;
			else
				ALUResult = 32'b 1;
		end
		//LI
		if (Operation == 5'b 01100) begin	
				//ALUResult = {DataA[31:16], DataB[15:0]}; 
				ALUResult =  DataB; 
		end
		//LUI
		if (Operation == 5'b 01101) begin	
				ALUResult = {DataB[15:0], DataA[15:0]};
		end
		//LWI
		if (Operation == 5'b 01110) begin
			ALUResult = DataB; //Address of where to load from
		end
		//LW
		if (Operation == 5'b 01111) begin
			ALUResult = DataB + Imm; //Address of where to load from
		end
		//SWI
		if (Operation == 5'b 10000) begin
			ALUResult = Imm;			//Address for where to write
		end
		//SW
		if (Operation == 5'b 10001) begin
			ALUResult = (DataA+DataB); //Address for where to write
		end

	end
endmodule
