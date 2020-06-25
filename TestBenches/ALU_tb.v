`include "ALU.v"

module ALU_tb3();

	reg [31:0] A,B;
	reg [3:0] Op;
	
	wire [31:0] Y;
	wire Overflow,Zero;

ALU ALU00(Overflow,Zero,Y,A,B,Op);

initial
begin
	A=32'd1;
	B=32'd5;
	Op=4'b0000;//and
	
end

always
begin
	$monitor("A= %b B= %b Y= %b  Zero=%b Overflow=%b",A,B,Y,Zero,Overflow);
	 $dumpfile("ALU.vcd");
      $dumpvars(0, ALU_tb3);
	//#5 Op=2'b1100;//NOR
	A=32'd1;B=32'd1;
	#5 Op=4'b0001;//OR
	#5 Op=4'b0010;//ADD
	#5 Op=4'b0111;//SLT
	#5 Op=4'b0110;//SUB
	#5 Op=4'b1100;//NOR
	
	//#5 A=32'd0;B=32'd0;
	#5 $finish;
end
endmodule