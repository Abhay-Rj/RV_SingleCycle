module ALU_1B(Y,CarryOut,A,B,Less,CarryIn,A_invert,B_invert,Op);
	input 		A,B,CarryIn,Less;
	input 		A_invert,B_invert;
	input [1:0] Op;
	output Y;
	output CarryOut;

	wire T1,T2;
	wire Y1;

	 ALU_adder Adder(Y1,CarryOut,T1,T2,CarryIn);


assign Y= (Op==2'b00)?(T1&T2):((Op==2'b01)?(T1|T2):((Op==2'b10)?Y1:Less));
assign T1=(A_invert)?(~A):A;
assign T2=(B_invert)?(~B):B;

endmodule


//Architecture 1
module ALU_adder (Sum,Carry,A,B,C);
	input A,B,C;
	output Sum,Carry;

	assign {Carry,Sum} = A+B+C;
endmodule

module ALU_1B_MSB(Set,Overflow,Y,CarryOut,A,B,Less,CarryIn,A_invert,B_invert,Op);
	input 		A,B,CarryIn,Less;
	input 		A_invert,B_invert;
	input [1:0] Op;
	output Y;
	output Set,Overflow,CarryOut;

	wire T1,T2;
	wire Y1;

	 ALU_adder Adder(Y1,CarryOut,T1,T2,CarryIn);

assign Set=Y1;

assign Y= (Op==2'b00)?(T1&T2):((Op==2'b01)?(T1|T2):((Op==2'b10)?Y1:Less));
assign T1=(A_invert)?(~A):A;
assign T2=(B_invert)?(~B):B;
/*
always@(Op,T1,T2,Y1)
begin
	if(Op==2'b00)
		Y=T1 & T2;
	else 
	begin
		if(Op==2'b01)
			Y=T1 | T2;
		else
		begin 	if(Op==2'b10)
					Y=Y1;
				else
					Y=Less;
		end
	end
end
*/
/*always@(A_invert,A)
begin
	if(A_invert)
		T1=~A;
	else
		T1=A;
end
always@(B_invert,B)
begin
	if (B_invert)
		T2=~B;
	else
		T2=B;
end
*/
always @(T1,T2,B_invert,CarryOut,Y1) 
begin
	

end
endmodule