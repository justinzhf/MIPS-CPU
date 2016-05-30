module MEMWB(readData,aluResult,out,clk,rst);
	input[31:0] readData,aluResult;
	output[63:0] out;
	input clk,rst;
	reg[63:0] out;

	initial
	begin
		out<=0;
	end
	always @(posedge clk or  rst) begin
		if (rst) begin
			// reset
			out<=0;
		end
		else begin
			out<={readData,aluResult};
		end
	end


endmodule