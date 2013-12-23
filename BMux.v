`timescale 1ns / 1ps

module BMux(BMuxOut, DataB, const, Imm, ALUSrcB
    );
//OUTPUTS-----------------------------------
	output [31:0] BMuxOut;
//INPUTS------------------------------------
	input [31:0] DataB, const, Imm;
	input [1:0] ALUSrcB;
//OTHER-------------------------------------
	reg [31:0] BMuxOut;
//CODE--------------------------------------
	 always @(DataB, const, Imm, ALUSrcB) begin
		if (ALUSrcB == 2'b00) begin
			BMuxOut = DataB;
		end
		if (ALUSrcB == 2'b01) begin
			BMuxOut = const;
		end
		if (ALUSrcB == 2'b10) begin
			BMuxOut = Imm;
		end
	 end
endmodule
