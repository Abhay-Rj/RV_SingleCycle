module bus_B(bus_B,operand_sel,RS2,sign_extended,store_immd);
output reg [31:0]bus_B;
input [1:0]operand_sel ;
input [31:0]RS2 ;
input [31:0]sign_extended;
input [31:0]store_immd ;

always@(operand_sel or RS2 or sign_extended)
begin
	case(operand_sel)
	2'b00: bus_B = RS2;    //for R-type instructions
	2'b01: bus_B = sign_extended; //for I-type and Load instructions
        2'b10: bus_B = store_immd;    //for Store
	endcase
end
endmodule
////////////////////////////////////////////////////
module bus_C(bus_C,Wrt_data_sel,Alu_out,D_in,PC);
output reg [31:0]bus_C;
input [1:0]Wrt_data_sel;
input [31:0]Alu_out;
input [31:0]D_in;
input [31:0]PC;
always@(Wrt_data_sel or Alu_out or D_in or PC)
begin
	case(Wrt_data_sel)
	2'b00:  bus_C= Alu_out;
	2'b01: bus_C = D_in;
        2'b10: bus_C = PC;
	endcase
end
endmodule