`timescale 1ns / 1ps

module ReadRegMux(RR1, RR2, IR_input
    );
//OUTPUT---------------
	output reg[4:0] RR1, RR2;
//INPUT---------------
	input [31:0] IR_input;
//OTHER----------------
//CODE----------------
always @ (IR_input) begin
	if (IR_input[31:30] == 2'b 10)begin //Branch instructions begin with 2'b 10
			RR1 = IR_input[25:21];
			RR2 = IR_input[20:16];
			end
		//For Loads
		else if (IR_input[31:26] == 6'b 111001) begin //LI
			RR1 = IR_input[25:21];
			RR2 = IR_input[20:16];
		end
		else if (IR_input[31:26] == 6'b 111010) begin //LUI
			RR1 = IR_input[25:21];
			RR2 = IR_input[20:16];
		end
		else if (IR_input[31:26] == 6'b 111011) begin //LWI
			RR1 = IR_input[25:21];
		end
		else if (IR_input[31:26] == 6'b 111101) begin //LW
			RR2 = IR_input[20:16];
		end
		else if (IR_input[31:26] == 6'b 111100) begin //SWI
			RR2 = IR_input[25:21]; //DataB is Write Data
		end
		else if (IR_input[31:26] == 6'b 111110) begin //SW
			RR2 = IR_input[25:21]; //DataB is place where data is pulled from
			RR1 = IR_input[20:16]; //DataA is Write Data
		end
		else begin
			RR1 = IR_input[20:16];
			RR2 = IR_input[15:11];
		end
	end
endmodule
