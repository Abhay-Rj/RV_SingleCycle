`include "ALU_4B.v"

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
