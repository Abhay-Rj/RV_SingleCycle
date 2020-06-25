module ALU(Overflow,Zero,Y,A,B,Op);
	input [31:0] A,B;
	input [3:0] Op;
	output [31:0] Y;
	output Zero,Overflow;

	wire CarryOut;

	ALU_32B ALU (Overflow,Zero,Y,CarryOut,A,B,32'd0,Op[2],Op[3],Op[2],Op[1:0]);

endmodule

module ALU_32B(Overflow,Zero,Y,CarryOut,A,B,Less,CarryIn,A_invert,B_invert,Op);
	output	[31:0]	 Y;
	output 			CarryOut,Overflow,Zero;
	input  	[31:0]	A,B,Less;
	input 			CarryIn;
	input 			A_invert,B_invert;
	input 	[1:0]	Op;


	wire [7:0] C;
	wire Set;

assign Zero=~|Y;
assign CarryOut=C[7];

ALU_4B 		   ALU0 (Y[ 3: 0],C[0],A[ 3: 0],B[ 3: 0],{Less [ 3: 1],Set}	,CarryIn,A_invert,B_invert,Op);
ALU_4B 		   ALU1 (Y[ 7: 4],C[1],A[ 7: 4],B[ 7: 4], Less [ 7: 4]	  	,C[0]	,A_invert,B_invert,Op);
ALU_4B 		   ALU2 (Y[11: 8],C[2],A[11: 8],B[11: 8], Less [11: 8]	  	,C[1]   ,A_invert,B_invert,Op);
ALU_4B 		   ALU3 (Y[15:12],C[3],A[15:12],B[15:12], Less [15:12]	  	,C[2]   ,A_invert,B_invert,Op);
ALU_4B 		   ALU4 (Y[19:16],C[4],A[19:16],B[19:16], Less [19:16]		,C[3]   ,A_invert,B_invert,Op);
ALU_4B 		   ALU5 (Y[23:20],C[5],A[23:20],B[23:20], Less [23:20]		,C[4]  	,A_invert,B_invert,Op);
ALU_4B 		   ALU6 (Y[27:24],C[6],A[27:24],B[27:24], Less [27:24]		,C[5]  	,A_invert,B_invert,Op);

ALU_4B_MSB ALU7_MSB (Set,Overflow,Y[31:28],C[7],A[31:28],B[31:28], Less [31:28]		,C[6]   ,A_invert,B_invert,Op);



endmodule

module ALU_4B(Y,CarryOut,A,B,Less,CarryIn,A_invert,B_invert,Op);
	output	[3:0]	 Y;
	output 			CarryOut;
	input  	[3:0]	A,B,Less;
	input 			CarryIn;
	input 			A_invert,B_invert;
	input 	[1:0]	Op;
	wire   [3:0]	GC;
	wire   [3:0]	C,G,P;

assign CarryOut=C[3];

ALU_1B ALU0 (Y[0],C[0]    ,A[0],B[0],Less[0],CarryIn,A_invert,B_invert,Op);
ALU_1B ALU1 (Y[1],C[1]    ,A[1],B[1],Less[1],C[0]   ,A_invert,B_invert,Op);
ALU_1B ALU2 (Y[2],C[2]    ,A[2],B[2],Less[2],C[1]   ,A_invert,B_invert,Op);
ALU_1B ALU3 (Y[3],C[3],A[3],B[3],Less[3],C[2]   ,A_invert,B_invert,Op);
/*
PG PG1(G[0],P[0],A[0],B[0]);
PG PG2(G[1],P[1],A[1],B[1]);
PG PG3(G[2],P[2],A[2],B[2]);
PG PG4(G[3],P[3],A[3],B[3]);

assign	GC[1] = G[0] + P[0]*CarryIn; 
assign	GC[2] = G[1] + P[1]*GC[1];
assign	GC[3] = G[2] + P[2]*GC[2];
assign  CarryOut = G[3] + P[3]*GC[3];
*/
endmodule


module ALU_4B_MSB(Set,Overflow,Y,CarryOut,A,B,Less,CarryIn,A_invert,B_invert,Op);
	output	[3:0]	 Y;
	output 			Set,Overflow,CarryOut;
	input  	[3:0]	A,B,Less;
	input 			CarryIn;
	input 			A_invert,B_invert;
	input 	[1:0]	Op;
//	wire   [3:0]	GC;
	wire   [3:0]	C,G,P;

assign CarryOut=C[3];

ALU_1B ALU0 (Y[0],C[0]    ,A[0],B[0],Less[0],CarryIn,A_invert,B_invert,Op);
ALU_1B ALU1 (Y[1],C[1]    ,A[1],B[1],Less[1],C[0]   ,A_invert,B_invert,Op);
ALU_1B ALU2 (Y[2],C[2]    ,A[2],B[2],Less[2],C[1]   ,A_invert,B_invert,Op);

ALU_1B_MSB ALU3_MSB (Set,Overflow,Y[3],C[3],A[3],B[3],Less[3],C[2]   ,A_invert,B_invert,Op);
/*
PG PG1(G[0],P[0],A[0],B[0]);
PG PG2(G[1],P[1],A[1],B[1]);
PG PG3(G[2],P[2],A[2],B[2]);
PG PG4(G[3],P[3],A[3],B[3]);

assign	GC[1] = G[0] + P[0]*CarryIn; 
assign	GC[2] = G[1] + P[1]*GC[1];
assign	GC[3] = G[2] + P[2]*GC[2];
assign  CarryOut = G[3] + P[3]*GC[3];
*/
endmodule


/*module PG(G,P,A,B);
input A,B;
output G,P;

 or X1(P,A,B);
and A1(G,A,B);

endmodule*/

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