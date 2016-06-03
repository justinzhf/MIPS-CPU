module BranchCtrl(EXMEMRd,MEMWBRd,IFIDRt,IFIDRs,opcode,EXMEMRdData,MEMWBRdData,mux_pc_sl);
	input[4:0] EXMEMRd,MEMWBRd,IFIDRs,IFIDRt;
	input[5:0] opcode;
	input[31:0] EXMEMRdData,MEMWBRdData;
	output mux_pc_sl;
	reg mux_pc_sl;

	always @(EXMEMRd or MEMWBRd or IFIDRt or IFIDRs or opcode or EXMEMRdData or MEMWBRdData) begin
		if(opcode==6'b000100 && (EXMEMRd==IFIDRs))
	end


endmodule