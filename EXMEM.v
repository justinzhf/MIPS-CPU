module EXMEM(addBranch,aluZero,aluResult,readData2,out,clk,rst);
	input[31:0] addBranch,aluResult,readData2;
	input aluZero,clk,rst;
	output[96:0] out;
	reg[96:0] out;

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
			out<={addBranch,aluZero,aluResult,readData2};
		end
	end

endmodule