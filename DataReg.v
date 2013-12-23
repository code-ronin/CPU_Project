`timescale 1ns / 1ps

module DataReg(DataOut, ReadData, clock, reset
    );
//OUTPUTS------------------------------
	output [31:0] DataOut;
//INPUTS-------------------------------
	input [31:0] ReadData;
	input clock, reset;
//OTHER--------------------------------
	reg [31:0] DataOut;
//CODE---------------------------------
	
	always @ (*) begin
	if (reset == 1) begin
		DataOut = 0;
	end
	else
		begin
		DataOut = ReadData;
		end
	end
endmodule
