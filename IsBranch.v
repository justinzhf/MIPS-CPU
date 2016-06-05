module IsBranch(in1,in2,opcode,out,IFFlush);
	input[31:0] in1,in2;
	input[5:0] opcode;
	output out,IFFlush;
	reg out,IFFlush;

	always @(in1 or in2 or opcode) begin
		if(opcode==6'b000100) begin
			if(in1==in2)begin
				out<=1;
				IFFlush<=1;
			end
			else begin
				out<=0;
				IFFlush<=0;
			end
		end
		else begin
			out<=0;
			IFFlush<=0;
		end
	end
endmodule