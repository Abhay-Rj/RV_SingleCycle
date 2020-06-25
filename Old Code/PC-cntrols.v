module PC_cntrl(PC_updated,PC_current,Br_offset,Jump_offset,UI_offset,branch,Reset,clock);
output reg [31:0]PC_updated;
input [31:0]PC_current;
input [31:0]Br_offset;
input [31:0]Jump_offset;
input [31:0]UI_offset;
input [ 1:0]branch;
input Reset, clock ;
always@(Reset or branch or posedge clock)
begin
	case(Reset)
	1'b1: 
		PC_updated=32'b0;
	1'b0:
	begin
		case(branch)
		2'b00:
			PC_updated= PC_current + 32'd4;
		2'b01:
			PC_updated= PC_current + Br_offset;
		2'b10:
			PC_updated= PC_current + UI_offset;
		2'b11:
			PC_updated= PC_current + Jump_offset;
		endcase
	end
endcase
end
endmodule


