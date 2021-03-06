module ImmGen(Out,Instruction);

output reg  [31:0] Out;
input  		[31:0] Instruction;

wire [6:0] Opcode;
wire [31:0] Ins;

assign Opcode = Instruction[6:0];	// Extract Opcode
assign Ins = Instruction;
// Extracts and Extends the Immediate values from different types of Instruction
	always@(Ins,Opcode)
		begin
			case(Opcode)
				7'b0000011 : Out = {{20{Ins[31]}},Ins[31:20]};
				// 12 Bit Imm at Ins[31:20] for I-type (Load,Arith,Jalr)
				7'b0010011 : Out = {{20{Ins[31]}},Ins[31:20]};
				// 12 Bit Imm at Ins[31:20] for I-type (Load,Arith,Jalr)
				7'b1100111 : Out = {{20{Ins[31]}},Ins[31:20]};
				// 12 Bit Imm at Ins[31:20] for I-type (Load,Arith,Jalr)
				7'b0100011	: Out = {{20{Ins[31]}},Ins[31:25],Ins[11:7]};
				// 12 Bit Imm at Ins[31:25],Ins[11:7] for S-Type
				7'b1100111  : Out = {{20{Ins[31]}},Ins[31],Ins[7],Ins[30:25],Ins[11:8]};
				// 12 Bit Imm for SB-type
				7'b1101111  : Out = {{12{Ins[31]}},Ins[31],Ins[19:12],Ins[20],Ins[30:21]};
				//  20 Bit Imm for UJ-Type
				7'b0110111	: Out = {Ins[31:12],12'h000};
				// 	20 Bit Imm for U-Type 
				default:	  Out= 32'hZZZZ;
			endcase // Opcode
		end
endmodule