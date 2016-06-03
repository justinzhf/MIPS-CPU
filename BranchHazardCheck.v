module BranchHazardCheck(EXMEMRd,MEMWBRd,IFIDRt,IFIDRs,opcode,forwardC,forwardD);
	input[4:0] EXMEMRd,MEMWBRd,IFIDRs,IFIDRt;
	input[5:0] opcode;
	input[31:0] EXMEMRdData,MEMWBRdData;
	output[1:0] forwardC,forwardD;
	reg mux_pc_sl;

	always @(EXMEMRd or IDEXRd or IFIDRt or IFIDRs or opcode or posedge clk) begin
		if(opcode==6'b000100 && (IDEXRd==IFIDRs))
	end


endmodule