module Memory_File(Address,Data,Wen,Clk,Rst);
	input [31:0] Address;
	output      [31:0] Data;
	input 	    	  Clk,Wen,Rst;

	reg        [31:0] mem [0:31];

	always @(posedge Clk) 
	begin
		if(~Rst) 
			begin
			 	$readmemh("Mem.txt",mem); 
			 end
	end
	

	assign Data = registerbank[Address] ;

	always @(posedge Clk) 
	begin
		if(Wen)
			registerbank[Address] <= Data;
	end
endmodule
