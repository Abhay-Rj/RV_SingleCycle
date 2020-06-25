`include "ALU_32B.v"

module ALU_tb2();

	reg [31:0] A,B,Less;
	reg [1:0] Op,Invert;
	reg CarryIn;
	wire [31:0] Y;
	wire Overflow,Zero;

ALU_32B ALU(Overflow,Zero,Y,CarryOut,A,B,Less,CarryIn,Invert[0],Invert[1],Op);

initial
begin
	A=32'd1;
	B=32'd5;
	Op=2'b00;
	Invert=2'b00;
	Less=32'd0;
end

always
begin
	$monitor("A= %b B= %b CarryIn=%b Y= %b CarryOut= %b Zero=%b Overflow=%b",A,B,CarryIn,Y,CarryOut,Zero,Overflow);
	 $dumpfile("ALU.vcd");
      $dumpvars(0, ALU_tb2);
	#5 Op=2'b01;
	#5 Op=2'b10;CarryIn=1'b0;
	#5 Op=2'b10;CarryIn=1'b1;
	#5 Op=2'b10;Invert[1]=1'b1;CarryIn=1'b1;
	#5 Op=2'b10;Invert[1]=1'b1;CarryIn=1'b1; A=32'd5;B=32'd1;
	//#5 A=32'd0;B=32'd0;
	#5 $finish;
end
endmodule