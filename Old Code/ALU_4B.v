`include "ALU_1B.v"

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