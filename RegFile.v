`timescale 1ns / 1ps

module RegFile(
	//outputs
	RD1, RD2,
	//inputs
	RegWrite, RR1, RR2, WR, WD, //Control signal, Read register 1 + 2, write register, write data
	clock, reset
	);
//OUTPUTS--------------------------
	output [31:0] RD1, RD2;
//INPUTS---------------------------
	input RegWrite;
	input [4:0]  RR1, RR2, WR;
	input [31:0] WD;
	input clock, reset;
//OTHER----------------------------
	reg [31:0] RD1, RD2;
	reg [31:0] reg0 = 0;
	reg [31:0] reg1 = 0;
	reg [31:0] reg2 = 0;
	reg [31:0] reg3 = 0;
	reg [31:0] reg4 = 0;
	reg [31:0] reg5 = 0;
	reg [31:0] reg6 = 0;
	reg [31:0] reg7 = 0;
	reg [31:0] reg8 = 0;
	reg [31:0] reg9 = 0;
	reg [31:0] reg10 = 0;
	reg [31:0] reg11 = 0;
	reg [31:0] reg12 = 0;
	reg [31:0] reg13 = 0;
	reg [31:0] reg14 = 0;
	reg [31:0] reg15 = 0;
	reg [31:0] reg16 = 0;
	reg [31:0] reg17 = 0;
	reg [31:0] reg18 = 0;
	reg [31:0] reg19 = 0;
	reg [31:0] reg20 = 0;
	reg [31:0] reg21 = 0;
	reg [31:0] reg22 = 0;
	reg [31:0] reg23 = 0;
	reg [31:0] reg24 = 0;
	reg [31:0] reg25 = 0;
	reg [31:0] reg26 = 0;
	reg [31:0] reg27 = 0;
	reg [31:0] reg28 = 0;
	reg [31:0] reg29 = 0;
	reg [31:0] reg30 = 0;
	reg [31:0] reg31 = 0;

//CODE-----------------------------
   always @(RR1, RR2,WR, WD) begin
	if (reset == 1) begin
		reg0 = 0;
		reg1 = 0;
		reg2 = 0;
		reg3 = 0;
		reg4 = 0;
		reg5 = 0;
		reg6 = 0;
		reg7 = 0;
		reg8 = 0;
		reg9 = 0;
		reg10 = 0;
		reg11 = 0;
		reg12 = 0;
		reg13 = 0;
		reg14 = 0;
		reg15 = 0;
		reg16 = 0;
		reg17 = 0;
		reg18 = 0;
		reg19 = 0;
		reg20 = 0;
		reg21 = 0;
		reg22 = 0;
		reg23 = 0;
		reg24 = 0;
		reg25 = 0;
		reg26 = 0;
		reg27 = 0;
		reg28 = 0;
		reg29 = 0;
		reg30 = 0;
		reg31 = 0;
	end
      case (RR1)
	0: RD1 = reg0;
	1: RD1 = reg1;
	2: RD1 = reg2;
	3: RD1 = reg3;
	4: RD1 = reg4;
	5: RD1 = reg5;
	6: RD1 = reg6;
	7: RD1 = reg7;
	8: RD1 = reg8;
	9: RD1 = reg9;
	10: RD1 = reg10;
	11: RD1 = reg11;
	12: RD1 = reg12;
	13: RD1 = reg13;
	14: RD1 = reg14;
	15: RD1 = reg15;
	16: RD1 = reg16;
	17: RD1 = reg17;
	18: RD1 = reg18;
	19: RD1 = reg19;
	20: RD1 = reg20;
	21: RD1 = reg21;
	22: RD1 = reg22;
	23: RD1 = reg23;
	24: RD1 = reg24;
	25: RD1 = reg25;
	26: RD1 = reg26;
	27: RD1 = reg27;
	28: RD1 = reg28;
	29: RD1 = reg29;	
	30: RD1 = reg30;	
	31: RD1 = reg31;	
	default: RD1 = 32'hXXXX;
      endcase
      case (RR2)
	0: RD2 = reg0;
	1: RD2 = reg1;
	2: RD2 = reg2;
	3: RD2 = reg3;
	4: RD2 = reg4;
	5: RD2 = reg5;
	6: RD2 = reg6;
	7: RD2 = reg7;
	8: RD2 = reg8;
	9: RD2 = reg9;
	10: RD2 = reg10;
	11: RD2 = reg11;
	12: RD2 = reg12;
	13: RD2 = reg13;
	14: RD2 = reg14;
	15: RD2 = reg15;
	16: RD2 = reg16;
	17: RD2 = reg17;
	18: RD2 = reg18;
	19: RD2 = reg19;
	20: RD2 = reg20;
	21: RD2 = reg21;
	22: RD2 = reg22;
	23: RD2 = reg23;
	24: RD2 = reg24;
	25: RD2 = reg25;
	26: RD2 = reg26;
	27: RD2 = reg27;
	28: RD2 = reg28;
	29: RD2 = reg29;	
	30: RD2 = reg30;	
	31: RD2 = reg31;	
	default: RD1 = 32'hXXXX;
      endcase
   end
   always @(posedge clock) begin
      if (RegWrite) 
	case (WR) 
	  0: reg0 <= WD;
	  1: reg1 <= WD;
	  2: reg2 <= WD;
	  3: reg3 <= WD;
	  4: reg4 <= WD;
	  5: reg5 <= WD;
	  6: reg6 <= WD;
	  7: reg7 <= WD;
	  8: reg8 <= WD;
	  9: reg9 <= WD;
	  10: reg10 <= WD;
	  11: reg11 <= WD;
	  12: reg12 <= WD;
	  13: reg13 <= WD;
	  14: reg14 <= WD;
	  15: reg15 <= WD;
	  16: reg16 <= WD;
	  17: reg17 <= WD;
	  18: reg18 <= WD;
	  19: reg19 <= WD;
	  20: reg20 <= WD;
	  21: reg21 <= WD;
	  22: reg22 <= WD;
	  23: reg23 <= WD;
	  24: reg24 <= WD;
	  25: reg25 <= WD;
	  26: reg26 <= WD;
	  27: reg27 <= WD;
	  28: reg28 <= WD;
	  29: reg29 <= WD;
	  30: reg30 <= WD;
	  31: reg31 <= WD;	  
	endcase // case (wrAddr)
   end // always @ (posedge clk)
endmodule
