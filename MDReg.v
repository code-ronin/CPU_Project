`timescale 1ns / 1ps

//Holds output from the Memory Data and pushes it at next clock cycle
module MDReg(MemDataOut, MemData, clock, reset
    );
//OUTPUTS------------------------------
	output [31:0] MemDataOut;
//INPUTS-------------------------------
	input [31:0] MemData;
	input clock, reset;
//OTHER--------------------------------
	reg [31:0] MemDataOut;
//CODE---------------------------------
	always @(MemData) begin
		if (reset == 1) begin
			MemDataOut = 0;
		end
		else begin
			MemDataOut = MemData;
		end
	end
endmodule
