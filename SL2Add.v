module SL2Add(in26,in4,out32);
	input[25:0] in26;
	input[3:0] in4;
	output[31:0] out32;
	reg[1:0] temp;

	initial
		temp=0;

	assign out32={in4,in26[23:0],temp};

endmodule