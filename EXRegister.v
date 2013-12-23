`timescale 1ns / 1ps

module EXRegister(
	//outputs
	 ALURegOut,
	//inputs
	 ALUResult, clock, reset
    );
//OUTPUTS-------------------------------------------
	output [31:0] ALURegOut;
//INPUTS--------------------------------------------
	input [31:0]  ALUResult;
	input clock, reset;
//OTHER---------------------------------------------
	reg [31:0] ALURegOut;
//CODE----------------------------------------------
	always @ (posedge clock) begin
		if (reset)begin
			ALURegOut = 0;
		end
		else
			
		begin
			ALURegOut = ALUResult;
		end
	end
endmodule
