module Reg_File(rs1Dat,rs2Dat,rs1Sel,rs2Sel,rdSel,rdDat,regWrite,Clk,Rst);

	input 	[31:0] Address,rdDat;
	output  [31:0] rs1Dat,rs2Dat;
	input 	[ 4:0] rs1Sel,rs2Sel,rdSel;	// Register Select
	input 	       Clk,regWrite,Rst;

	reg        [31:0] regmem [0:31];

	always @(posedge Clk or negedge Rst) 
	begin
		if(~Rst) 
			begin
			 	$readmemh("Rmem.txt",regmem); 
			 end
	end
	
	assign rs1Dat = regmem[rs1Sel] ;
	assign rs2Dat = regmem[rs2Sel] ;

	always @(negedge Clk) 
	begin
		if(regWrite)
			regmem[rdSel] <= rdDat; 
	end
endmodule
