`include "ALU_4B.v"

module ALU_tb1();

	reg [3:0] A,B;
	reg [1:0] Op,Invert;
	reg CarryIn,Less;
	wire [3:0] Y;

ALU_4B ALU(Y,CarryOut,A,B,Less,CarryIn,Invert[0],Invert[1],Op);

initial
begin
	A=4'b1101;
	B=4'b1010;
	Op=2'b00;
	Invert=2'b00;
	Less=1'b0;
end

always
begin
	$monitor("A= %b B= %b CarryIn=%b Y= %b CarryOut= %b ",A,B,CarryIn,Y,CarryOut);
	#5 Op=2'b01;
	#5 Op=2'b10;CarryIn=1'b0;
	#5 Op=2'b10;CarryIn=1'b1;
	#5 Op=2'b11;
	#5 $finish;
end
endmodule