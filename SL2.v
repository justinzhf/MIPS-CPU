module SL2ADD(in26,out32);
	input[25:0] in26;
	output[31:0] out32;
	reg[5:0] temp;

	initial begin
		temp=0;
	end

	out32={temp}

endmodule