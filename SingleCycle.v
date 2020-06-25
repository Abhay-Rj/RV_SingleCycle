// Single Cycle Implementation for beq,Add,Sub,R,I-type.
`include "ALU.v"
`include "Imem.v"
`include "Rmem.v"
`include "Dmem.v"
`include "Alu_cntrl.v"
`include "controller.v"
`include "ImGen.v"
//`include ""

module TOP(Clk,Rst);

input Clk, Rst;
wire [31:0] PC,BA,Instruction,PC_4,PC_in,readData;
wire [31:0] busA,busB,rs1Dat,rs2Dat,rdDat,Alu_out,imm32,imm32s;
wire [ 4:0] rs1Sel,rs2Sel,rdSel;
wire [ 3:0] ALUCntrl;
wire [ 1:0] ALU_op;

wire memRead,memWrite,regWrite,PCSrc,ALUSrc,branch,memtoreg;

reg [31:0] PC_reg;
assign PC=PC_reg;
assign imm32s= (imm32<<1);

assign rs1Sel=Instruction[19:15];
assign rs2Sel=Instruction[24:20];
assign rdSel =Instruction[11: 7];

assign busA  = (~Lui)?rs1Dat:32'd0;  // for LUI
assign busB  = (~ALUSrc)?rs2Dat:imm32;
assign rdDat = (memtoreg)?Alu_out:readData; // memtoreg= 1 ALU writes back to Register, else Data Memory Writebacks
assign PC_in = (~PCSrc)?PC_4:BA; //PCSrc=0, PC+4 else Branch Address
assign PCSrc = branch && Zero; // BEQ


	add PC_4_Adder(PC_4,PC,32'd4); // PC incrementer, PC_4=PC+4;

	add BranchAddressAdder(BA,PC,imm32s); // PC + (Offset<<1), PC_4=PC+Shifted Immediate;

	IMemory_File InstructionMemory(PC,Instruction,Clk,Rst);

	Control  ControlDecode(Instruction[6:0],ALUSrc,memtoreg,regWrite,memRead,memWrite,AddSel,Link,Lui,branch,ALU_op);

	ImmGen   ImmediateGenerator(imm32,Instruction);

	Reg_File GPRegisters(rs1Dat,rs2Dat,rs1Sel,rs2Sel,rdSel,rdDat,regWrite,Clk,Rst);

	ALU ALU0(Overflow,Zero,Alu_out,busA,busB,ALUCntrl);

	ALU_Control ACTL (Instruction,ALU_op,ALUCntrl);

	DMemory_File DataMemory(Alu_out,readData,rs2Dat,memRead,memWrite,Clk,Rst);


	always@(posedge Clk or negedge Rst)
	begin
		if(~Rst)
			PC_reg<=32'd0;
		else
			PC_reg<=PC_in;
	end

endmodule

module add(C,A,B);
	input  [31:0] A,B;
	output reg [31:0] C;

	always@(A,B)
	begin
		C=A+B;
	end
endmodule