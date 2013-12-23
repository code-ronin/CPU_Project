`timescale 1ns / 1ps

module WRMux(WR, IROut
    );
//OUTPUTS------------------------
	output reg [4:0] WR;
//INPUTS-------------------------
	input [31:0] IROut;
//OTHER--------------------------
//CODE---------------------------

always @(*) begin
	if (IROut[31:26] == 6'b 000010)
		WR = 5'b 11111;
	else 
		WR = IROut[25:21];
end
endmodule
