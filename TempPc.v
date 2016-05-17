module TempPc(in,out,clk);
	input[31:0] in;
	output[31:0] out;
	input clk;
	reg[31:0] out;
	initial
	begin
		out=0;
	end
	always @(posedge clk) begin
		out<=in;
	end

endmodule