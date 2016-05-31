module MEMWB(wb,readData,aluResult,rtd,out,clk,rst);
	input[31:0] readData,aluResult;
	output[70:0] out;
	input clk,rst;
	input[1:0] wb;
	input[4:0] rtd;
	reg[70:0] out;

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
			out<={wb,readData,aluResult,rtd};
		end
	end


endmodule