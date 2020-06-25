module ALU_Control(func,ALU_cntrl,alu_op); //out is the control signal to the alu which will tell it the operation to be performed
input [31:0]func;
input [1:0]ALU_cntrl;
output reg [3:0]alu_op;

always@(func or ALU_cntrl)
begin
	case(ALU_cntrl)
	2'b00: //LW,SW ALU should perform ADD operation for address calculation
		alu_op = 4'b0010;
	2'b01://for branch instructions alu should perform subtraction
		alu_op = 4'b0110 ;
	2'b10://for R-type and I-type instructions operation performed based on f7 and f3
		case({func[30],func[14:12]})
			 4'b0000: // ALU should perform ADD
				alu_op = 4'b0010;
			 4'b1000: // ALU should perform SUB
				alu_op = 4'b0110;
			 4'b0001: // ALU should perform SLL
				alu_op = 4'b1101;
			 4'b0010: // ALU should perform SLT
				alu_op = 4'b0111;
			 4'b0011: // ALU should perform SLTU
				alu_op = 4'bzzzz;
			 4'b0100: // ALU should perform XOR
				alu_op = 4'b1100;
			 4'b0101: // ALU should perform SRL
				alu_op = 4'b1110;
			 4'b1101: // ALU should perform SRA
				alu_op = 4'b1000;
			 4'b0110: // ALU should perform OR
				alu_op = 4'b0001;	
			 4'b0111: // ALU should perform AND
				alu_op = 4'b0000;	
	
	2'b11://for B-Type and J-Type instruction ALU is in idle state
               alu_op=4'bzzzz;
endcase
	endcase
end
endmodule