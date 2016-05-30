module IDEX(wb,m,ex,add4,readData1,readData2,signExt,rt,rd,out,clk,rst);
	input[31:0] add4,readData1,readData2,signExt;
	input[1:0] wb;
	input[2:0] m;
	input[3:0] ex;
	input[4:0] rt;
	input[4:0] rd;
	output[146:0] out;
	input clk,rst;
	reg[146:0] out;

	initial
	begin
		out<=0;
	end

	always @(posedge clk or  rst) begin
		if (rst) begin
			// reset
			out<=0;
		end
		else  begin
			out<={wb,m,ex,add4,readData1,readData2,signExt,rt,rd};
		end
	end

endmodule