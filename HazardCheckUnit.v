module HazardCheckUnit(IDEXMemRead,IDEXRt,IFIDRs,IFIDRt,PCWrite,IFIDWrite,ctrlSetZero);
	input[4:0] IDEXRt,IFIDRt,IFIDRs;
	input IDEXMemRead;
	output PCWrite,IFIDWrite,ctrlSetZero;
	reg PCWrite,IFIDWrite,ctrlSetZero;

	initial
	begin
		PCWrite<=1;
		IFIDWrite<=1;
		ctrlSetZero<=0;
	end
	always @(IDEXMemRead or IDEXRt or IFIDRs or IFIDRt) begin
		if(IDEXMemRead && ((IDEXRt==IFIDRs) || (IDEXRt==IFIDRt))) begin
			PCWrite<=0;
			IFIDWrite<=0;
			ctrlSetZero<=1;
		end
		else begin
			PCWrite<=1;
			IFIDWrite<=1;
			ctrlSetZero<=0;
		end
	end
endmodule