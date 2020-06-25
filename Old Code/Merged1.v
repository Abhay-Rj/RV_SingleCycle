`include "ALU.v"
`include "Register_File.v"
`include "Memory_File.v"
`include "Alu_cntrl.v"
`include "Bus_controls.v"
`include "PC-cntrols.v"
`include "controller.v"
`include "sign_extension.v"


module TOP(IRE,Clk,Rst);
input [31:0] IRE;
input Clk, Rst;
wire [31:0] AO;
wire [31:0] PC,DI,PC_current,RS2Dat;
wire [31:0] busB,RS1Dat,RDDat,Alu_out,extended_out;
wire [ 3:0] Op;
wire [ 1:0] wrt_data_sel,ALU_cntrl,operand_sel,branch;
wire wrt_en,wrt_add_sel;

sign_extend_12 SXT (IRE[31:20],extended_out16);
sign_extend_20 SXT1(IRE[31:12],extended_out20);

Memory_File IMF	();

PC_cntrl      PC1 (AO,PC,32'd0,32'd0,32'd0,branch,Rst,Clk);

Register_File RF (IRE[19:15],IRE[24:20],IRE[11:7],wrt_en,RS1Dat,RS2Dat,RDDat,Clk,Rst);

	
Memory_File MF   (AO,DI,wrten,Clk,Rst);

	bus_B	BUSB (busB,operand_sel,RS2Dat,extended_out12,32'd0);

	bus_C   BUSC (RDDat,wrt_data_sel,Alu_out,DI,PC);

ALU_Control ACTL (IRE,ALU_cntrl,Op);

	control  CTL (IRE[6:0] , ALU_cntrl , wrt_en, wrt_add_sel,wrt_data_sel,operand_sel,branch);

		ALU ALU00(Overflow,Zero,Alu_out,RS1Dat,busB,Op);


assign AO=(wrt_add_sel)?PC: Alu_out;


endmodule

