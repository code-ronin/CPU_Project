`timescale 1ns / 1ps

module Three2One(newPC, ALUResult, ALURegOut, jumpaddress, PC, PCSource
    );
//OUTPUTS---------------------
	output [31:0] newPC;
//INPUTS----------------------
	input [31:0] ALUResult, ALURegOut, jumpaddress, PC; //increment, branch, and jump, respectivly
	input [1:0] PCSource;
//OTHER-----------------------
	reg [31:0] newPC;
//CODE------------------------
	always @ (ALUResult, ALURegOut, jumpaddress, PCSource) begin
		if (PCSource == 2'b 00)begin
			newPC = ALUResult; //+1
		end
		if (PCSource == 2'b 01)begin
			newPC = PC+ALURegOut; //Branch
		end
		if (PCSource == 2'b 10)begin
			newPC = PC+jumpaddress; //Jump
		end
		if (PCSource == 2'b 11) begin
			newPC = PC; //Null statement
		end
	end
endmodule
