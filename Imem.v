module IMemory_File(Address,Data,Clk,Rst); // Combinational Memory similar to ROM
	input 		[31:0] Address;
	output      [31:0] Data;
	input 	    	  Clk,Rst;

	reg        [ 7:0] imem [0:63];

	always @(posedge Clk or negedge Rst) 
	begin
		if(~Rst) 
			begin
			 	$readmemh("Imem.txt",imem); // Initialize 64 Byte Memory
			 end
	end
	
	assign Data = {imem[Address+3],imem[Address+2],imem[Address+1],imem[Address+0]} ;
			 // Instruction Memory only Reads data, scoops 4 Bytes at one read(little-endian)

endmodule