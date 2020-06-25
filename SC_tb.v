`include "SingleCycle.v"

module TB();

reg Rst,Clk;

	TOP TOP1(Clk,Rst);

initial begin
	Rst=1'b0;
	Clk =1'b0;
	#1 Rst=1'b1;

	forever	#5 Clk = !Clk;
	end

initial
	begin

	 $dumpfile("M.vcd");
      $dumpvars(0, TB);


	#100 $finish;
	end
endmodule