module HazardCheckUnit(IDEXMemRead,IDEXRt,IFIDRs,IFIDRt,PCWrite,IFIDWrite,ctrlSetZero,IDEXRd,IDEXRegWrite,opcode,EXMEMRead,EXMEMRt,clk);
	input[4:0] IDEXRt,IFIDRt,IFIDRs,IDEXRd,EXMEMRt;
	input IDEXMemRead,IDEXRegWrite,EXMEMRead;
	input[5:0] opcode;
	input clk;
	output PCWrite,IFIDWrite,ctrlSetZero;
	reg PCWrite,IFIDWrite,ctrlSetZero;

	initial
	begin
		PCWrite<=1;
		IFIDWrite<=1;
		ctrlSetZero<=0;
	end
	always @(opcode or IDEXMemRead or IDEXRt or IFIDRs or IFIDRt or IDEXRd or IDEXRegWrite or  clk) begin
		if(opcode==6'b000100)begin
			if(IDEXMemRead && ((IDEXRt==IFIDRs) || (IDEXRt==IFIDRt))) begin//beq,lw,stall 2 clks
				PCWrite<=0;
				IFIDWrite<=0;
				ctrlSetZero<=1;
			end
			else if(IDEXRegWrite && ((IDEXRd==IFIDRs) || (IDEXRd==IFIDRt)))begin//beq,R,stall 1 clk
				PCWrite<=0;
				IFIDWrite<=0;
				ctrlSetZero<=1;
			end
			else begin
				PCWrite<=1;
				IFIDWrite<=1;
				ctrlSetZero<=0;
			end
			if(EXMEMRead && ((EXMEMRt==IFIDRs) || (EXMEMRt==IFIDRt)))begin
				PCWrite<=0;
				IFIDWrite<=0;
				ctrlSetZero<=1;
			end
		end
		else begin
			if(IDEXMemRead && ((IDEXRt==IFIDRs) || (IDEXRt==IFIDRt))) begin//R,lw,stall 1 clk
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
				
	end
endmodule