
module CPUv2(PC, Inst, ALUOutput, A, B, RegisterA, RegisterB, OpCode, MDR, state, Mem_write, clock, reset
    );
//OUTPUTS------------------------------------
	output [31:0] PC, Inst, ALUOutput, A, B, RegisterA, RegisterB, OpCode, MDR, state;
	output Mem_write;
//INPUTS------------------------------------
	input clock, reset;
//OTHER--------------------------------------
	reg [31:0] PC = 0;  //Initialize PC to zero
	reg [31:0] Inst;
	reg [31:0] ALUOutput;
	reg [31:0] RegisterA, RegisterB;
	reg [31:0] A, B;
	reg [4:0] OpCode;
	reg [31:0] MDR;
	reg [3:0] check_state;
	reg Mem_write;
	wire [31:0] newPC;
	wire [31:0] jumpaddress, jumpaddress2;
	wire [31:0] branchaddress, branchaddress2;
	wire 			incre, jumpcond, branchcond, incre2, jumpcond2, branchcond2;
	wire [31:0] IROut;
	//CPU Controller--------------
	wire IorD;
	wire MemWrite;
	wire MemtoReg;
	wire [1:0] PCSource;
	wire [5:0] ALUOp;
	wire [1:0] ALUSrcB;
	wire ALUSrcA;
	wire RegWrite;
	reg[3:0] state = 0; //Initilize state
	wire [3:0] next_state;
	//---------------------------------------
	//ID controls
	wire [4:0] RR1, RR2;
	wire [31:0] RD1, RD2, WD;
	wire [4:0]  WR;
	//ALU Controls-EX stage
	wire [31:0] Imm;
	//wire ALUSrcA;
	wire [31:0] AMuxOut, BMuxOut;
	wire [31:0] ALUResult, DataA, DataB;
	wire [4:0] Operation;
	wire [31:0] ALURegOut;
	
	//MEM controls
	wire [31:0] DMemMux;
	wire [31:0] MemData;
	wire [31:0] MemDataReg;
//CODE----------------------------------------(BEGIN HERE)-----------------------------------------------------------
	//This block of code gives some of the main outputs to ensure the CPU is working
	always @ (posedge clock) begin
		if (reset == 1) begin
			PC = 0;
		end
		else begin
		PC = newPC;
		state = next_state;
		Inst = IROut;
		ALUOutput = ALUResult;
		OpCode = Operation;
		RegisterA = RD1;
		RegisterB = RD2;
		A = AMuxOut;	//Result going into ALU
		B = BMuxOut;	//Result going into ALU
		MDR = MemData; //nothing in memory initial, so all XXXXX's expected
		Mem_write = MemWrite;
		end
	end
	
//IF stage
	//Get new instruction
	IMem IM0 (PC, IROut);

//ID stage
	//CPU Controller
	Control ctrl(
	IorD,
	MemWrite,
	MemtoReg,
	PCSource,
	ALUOp,
	ALUSrcB,
	ALUSrcA,
	RegWrite,
	state,
	next_state,
	IROut[31:26], clock);
	
	//Access Register file
	assign WD = MemtoReg ? MemDataReg : ALURegOut;
	//assign WR here. It only changes for JAL, the write register being reg32
	WRMux newWR(WR, IROut);
	//Choose which registers to read and read from reg file
	ReadRegMux RRM (RR1, RR2, IROut);
	RegFile RF0(RD1, RD2, RegWrite, RR1, RR2, WR, WD, clock, reset);
	//Store RD1 and RD@ in Reg files
	DataReg A0 (DataA, RD1, clock, reset);
	DataReg B0 (DataB, RD2, clock, reset);
//EX stage
	//Call ALUcontrol
	ALUControl AU0 (Operation, ALUOp);
	//Sign Extend Immediate if necessary, else this will Zero extend
	SignExtender SE0(Imm, IROut, ALUOp);
	//MUXs for ALU inputs (choose ALU input values here)
	assign AMuxOut = ALUSrcA ? DataA : PC;
	BMux Bval(BMuxOut, DataB, 32'd1, Imm, ALUSrcB);
	//call mainALU. This does all calculations
	MainALU MA0 (ALUResult, AMuxOut, BMuxOut, Operation, IROut, Imm);
	//Store PC update logic and ALUResult here
	EXRegister Reg4(ALURegOut, ALUResult,clock, reset);
//MEM stage
	//Write to DMem. This module is always reading.
	assign DMemMux = IorD ? ALURegOut : PC;
	DMem DM0 (DataB, MemData, DMemMux, MemWrite);
	MDReg MDR0 (MemDataReg, MemData, clock, reset);
//WB Stage
	//Update PC here
	assign jumpaddress = {6'b 0000_00,IROut[25:0]};
	Three2One upPC (newPC, ALUResult, ALURegOut, jumpaddress, PC, PCSource);
	
endmodule

