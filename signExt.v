module signExt(in1,out);
	input[15:0] in1;
	output[31:0] out;
	wire[15:0] temp;

	assign temp=in1[15]==0?16'h0000:16'hffff;
	assign out ={temp[15:0],in1[15:0]} ;


endmodule