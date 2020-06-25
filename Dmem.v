module DMemory_File(Address,readData,writeData,memRead,memWrite,Clk,Rst);

	input 	[31:0] Address,writeData;
	output  [31:0] readData;
	input 	       Clk,memWrite,memRead,Rst;

	reg        [7:0] dmem [0:63];


	always @(posedge Clk or negedge Rst) 
	begin
		if(~Rst) 
			begin
			 	$readmemh("Dmem.txt",dmem); 
			 end
	end
	
	assign readData = (memRead)?{dmem[Address+3],dmem[Address+2],dmem[Address+1],dmem[Address]}:32'hZZZZ;

	always @(negedge Clk) 
	begin
		if(memWrite)
			{dmem[Address+3],dmem[Address+2],dmem[Address+1],dmem[Address]} <= writeData; //Little Endian
	end
endmodule
