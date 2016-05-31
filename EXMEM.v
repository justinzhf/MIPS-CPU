module EXMEM(wb,m,addBranch,aluZero,aluResult,readData2,mw5Out,out,clk,rst);
	input[31:0] addBranch,aluResult,readData2;
	input aluZero,clk,rst;
	input[1:0] wb;
	input[2:0] m;
	input[4:0] mw5Out;
	output[106:0] out;
	reg[106:0] out;

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
			out<={wb,m,addBranch,aluZero,aluResult,readData2,mw5Out};
		end
	end

endmodule