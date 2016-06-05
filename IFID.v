module IFID(addr4,ins,out,clk,rst,IFIDWrite,IFFlush);
	input[31:0] addr4,ins;
	output[63:0] out;
	input clk,rst,IFFlush;
	input IFIDWrite;
	reg[63:0] out;

	initial
	begin
		out<=0;
	end

	always @(posedge clk or rst) begin
		if (rst)out<=0;
		else if(IFIDWrite==0);
		else if(IFFlush)out<={addr4,32'b0};
		else out<={addr4,ins};
	end

endmodule