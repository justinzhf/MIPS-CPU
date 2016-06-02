module muxthree(in1,in2,in3,sl,out);
	input[31:0] in1,in2,in3;
	input[1:0] sl;
	output[31:0] out;
	reg[31:0] out;

	always @(sl or in1 or in2 or in3) begin
		if (sl==2'b00) out<=in1;
		else if(sl==2'b01) out<=in2;
		else if(sl==2'b10) out<=in3;
		else out<=0;
	end
endmodule