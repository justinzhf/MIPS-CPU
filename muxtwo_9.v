module muxtwo_9(in1,in2,sl,out);
	input[8:0] in1;
	input[8:0] in2;
	input sl;
	output[8:0] out;

	assign out=(sl==0)?in1:in2;

endmodule