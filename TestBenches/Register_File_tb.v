`include "Register_File.v"
module Register_File_tb;
	reg    [4:0]  RS1Sel,RS2Sel,RDSel;
	wire  [31:0] RS1Dat,RS2Dat;
	reg   [31:0] RDDat;
	reg          wen,Clk,Rst;

Register_File RF (RS1Sel,RS2Sel,RDSel,wen,RS1Dat,RS2Dat,RDDat,Clk,Rst);

initial
	begin
		Rst=1'b0;
		Clk=1'b0;
		wen=1'b0;  //write disabled
	
		forever
		#1 Clk=~Clk;
	end

initial
	begin
      $dumpfile("RF.vcd");
      $dumpvars(0, Register_File_tb);

	  #10 Rst =1'b1;
	  #15 RS1Sel=5'd0;RS2Sel=5'd2;RDSel=5'd2;
	  #20 RDDat=32'hFFFFFFCF;
	  #2 wen=1'b1;
	  #2wen=1'b0;RDSel=5'd0;
	  #2 RDDat=32'hFFFCFFFC;
	  #2 wen=1'b1;
	  

	  #2 Rst=1'b0;

		//$monitor($time," ,Clock = %b,Reset= %b  MX= %b MY=%b Product=%b ",Clk,Reset,MX,MY,FP);
	 	// #10 Reset=1'b1;
		//MX=16'd1;MY=9'd1;
		//MX=16'hFFFF;MY=9'd4;//ANS= 3FFFC
		// MX=16'hFFFF;MY=9'h1FF;//ANS= 1FEFE01
		//#30 Reset=1'b0;	
	$finish;
	end
endmodule
	