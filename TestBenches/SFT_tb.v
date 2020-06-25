`include "SFT.v"

module SFT_tb();

	reg [31:0] A,B;
	reg [1:0] Op;
	wire [31:0] Y;

	SFT S(Y,A,B,Op);

initial 
begin
	A=-32'd15;B=32'd3;
end

initial
	begin
      $dumpfile("SFT.vcd");
      $dumpvars(0, SFT_tb);
      $monitor("A=%b B=%d  Y=%b Op=%b",A,B,Y,Op);

      #5 Op=2'b00;
      #5 Op=2'b01;
      #5 Op=2'b10;

	$finish;
	end
endmodule
