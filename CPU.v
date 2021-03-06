`include"PC.v"
`include"IM.v"
`include"controlUnit.v"
`include"RegHeap.v"
`include"muxtwo_4.v"
`include"signExt.v"
`include"muxtwo_32.v"
`include"ALUControl.v"
`include"ALU.v"
`include"DM.v"
`include"Add4.v"
`include"AddBranch.v"
`include"SL2Add.v"
`include"IFID.v"
`include"IDEX.v"
`include"EXMEM.v"
`include"MEMWB.v"
`include"muxtwo_5.v"
`include"muxthree.v"
`include"SwapUnit.v"
`include"muxtwo_9.v"
`include"HazardCheckUnit.v"
`include"IsBranch.v"
module CPU(clk,rst);
	input clk;
	input rst;
	wire[31:0] pcInputAddr; //type 'reg' for test
	reg[31:0] tempPcInAddr;

	wire[31:0] pcOutAddr;
	wire[31:0] imOutData;
	wire[9:0] ctrlUnitOutCode;

	wire[31:0] reg1Data;
	wire[31:0] reg2Data;
	wire[4:0] writeReg;
	wire[31:0] extSign32;//符号扩展单元
	wire[31:0] mw32Out;
	wire[3:0] aluctrl;//alu的控制信号
	wire[31:0] aluResult;//ALU运算结果
	wire[31:0] dmOutData;
	wire[31:0] pcPlus4;
	wire[31:0] addBranchOut;
	wire zero;
	wire andOut;
	wire[31:0] branOrPc;
	wire[31:0] sl2AddOut;


	wire[31:0] writeData;//for test
	wire rst;
	reg[4:0] readReg1_t,readReg2_t;
	wire[31:0] reg1Data_t,reg2Data_t;
	reg writeReg_t;
	reg test;

	wire[63:0] ifidOut;
	wire[151:0] idexOut;
	wire[106:0] exmemOut;
	wire[70:0] memwbOut;
	wire[4:0] mw5Out;
	wire[31:0] mw32_memOut;
	wire[31:0] mt1Out,mt3Out,mt4Out;
	wire[31:0] mt2Out;
	wire[1:0] forwardA,forwardB,forwardC,forwardD;
	wire[8:0] mw9Out;
	wire PCWrite;
	wire ctrlSetZero;
	wire IFIDWrite;
	wire isBranchOut;
	wire IFFlush;
	wire overflow;
	wire[31:0] pc1Out;
	initial
	begin
	end
		
		muxtwo_32 mw32_pc1(.in1(pcPlus4),.in2(addBranchOut),.sl(isBranchOut),.out(pc1Out));
		SL2Add sl2Add(.in26(ifidOut[25:0]),.in4(pcPlus4[31:28]),.out32(sl2AddOut));
		muxtwo_32 mw32_pc2(.in1(pc1Out),.in2(sl2AddOut),.sl(ctrlUnitOutCode[9]),.out(pcInputAddr));
		PC pc(.inAddr(pcInputAddr),.outAddr(pcOutAddr),.clk(clk),.rst(rst),.PCWrite(PCWrite),.overflow(overflow));
		Add4 add4(.inAddr(pcOutAddr),.outAddr(pcPlus4));
		IM im(.inAddr(pcOutAddr),.outContent(imOutData));//imOutData为读出的指令

		IFID ifid(.addr4(pcPlus4),.ins(imOutData),.out(ifidOut),.clk(clk),.rst(rst),.IFIDWrite(IFIDWrite),.IFFlush(IFFlush));

		HazardCheckUnit hazardCheck(.IDEXMemRead(idexOut[143]),.IDEXRt(idexOut[9:5]),.IFIDRs(ifidOut[25:21]),.IFIDRt(ifidOut[20:16]),.PCWrite(PCWrite),.IFIDWrite(IFIDWrite),.ctrlSetZero(ctrlSetZero),.IDEXRd(idexOut[4:0]),.IDEXRegWrite(idexOut[145]),.opcode(ifidOut[31:26]),.EXMEMRead(exmemOut[103]),.EXMEMRt(exmemOut[4:0]),.clk(clk));
		controlUnit controlunit(.inCode(ifidOut[31:26]),.outCode(ctrlUnitOutCode));
		muxthree mt3(.in1(reg1Data),.in2(mw32_memOut),.in3(exmemOut[68:37]),.sl(forwardA),.out(mt3Out));
		muxthree mt4(.in1(reg2Data),.in2(mw32_memOut),.in3(exmemOut[68:37]),.sl(forwardB),.out(mt4Out));
		IsBranch isBranch(.in1(mt3Out),.in2(mt4Out),.opcode(ifidOut[31:26]),.out(isBranchOut),.IFFlush(IFFlush));
		AddBranch addBranch(.inAddr_add(ifidOut[63:32]),.inAddr_sl2(extSign32*4),.outAddr(addBranchOut));
		muxtwo_9 mw9(.in1(ctrlUnitOutCode[8:0]),.in2(0),.sl(ctrlSetZero),.out(mw9Out));
		signExt signext(.in1(ifidOut[15:0]),.out(extSign32));
		RegHeap regHeap(.readReg1(ifidOut[25:21]),.readReg2(ifidOut[20:16]),.writeReg(memwbOut[4:0]),.regWrite(memwbOut[69]),.writeData(mw32_memOut),.reg1Data(reg1Data),.reg2Data(reg2Data),.clk(clk));

		IDEX idex(.rs(ifidOut[25:21]),.wb({ctrlUnitOutCode[6],mw9Out[5]}),.m({mw9Out[2],mw9Out[4],mw9Out[3]}),.ex({mw9Out[7],mw9Out[8],mw9Out[1],mw9Out[0]}),.add4(ifidOut[63:32]),.readData1(reg1Data),.readData2(reg2Data),.signExt(extSign32),.rt(ifidOut[20:16]),.rd(ifidOut[15:11]),.out(idexOut),.clk(clk),.rst(rst));

		SwapUnit swapUnit(.rs(idexOut[151:147]),.rt(idexOut[9:5]),.rd(idexOut[4:0]),.EXMEMregWrite(exmemOut[105]),.EXMEMregisterRd(exmemOut[4:0]),.MEMWBregisterRd(memwbOut[4:0]),.MEMWBregWrite(memwbOut[69]),.forwardA(forwardA),.forwardB(forwardB),.rst(rst));
		muxthree mt1(.in1(idexOut[105:74]),.in2(mw32_memOut),.in3(exmemOut[68:37]),.sl(forwardA),.out(mt1Out));
		muxthree mt2(.in1(idexOut[73:42]),.in2(mw32_memOut),.in3(exmemOut[68:37]),.sl(forwardB),.out(mt2Out));
		muxtwo_32 mw32(.in1(mt2Out),.in2(idexOut[41:10]),.sl(idexOut[141]),.out(mw32Out));
		ALUControl aluControl(.func(idexOut[15:10]),.aluop({idexOut[139],idexOut[138]}),.aluctrl(aluctrl));
		ALU alu(.in1(mt1Out),.in2(mw32Out),.ctrl(aluctrl),.out(aluResult),.zero(zero),.overflow(overflow));
		muxtwo_5 mw5(.in1(idexOut[9:5]),.in2(idexOut[4:0]),.sl(idexOut[140]),.out(mw5Out));

		EXMEM exmem(.wb({idexOut[146],idexOut[145]}),.m({idexOut[144],idexOut[143],idexOut[142]}),.addBranch(addBranchOut),.aluZero(zero),.aluResult(aluResult),.readData2(mt2Out),.mw5Out(mw5Out),.out(exmemOut),.clk(clk),.rst(rst));

		DM dm(.inAddr(exmemOut[68:37]),.writeData(exmemOut[36:5]),.memRead(exmemOut[103]),.memWrite(exmemOut[102]),.outData(dmOutData),.clk(clk));

		MEMWB memwb(.wb({exmemOut[106],exmemOut[105]}),.readData(dmOutData),.aluResult(exmemOut[68:37]),.rtd(exmemOut[4:0]),.out(memwbOut),.clk(clk),.rst(rst));

		muxtwo_32 mw32_mem(.in1(memwbOut[36:5]),.in2(memwbOut[68:37]),.sl(memwbOut[70]),.out(mw32_memOut));



		/*AddBranch addBranch(.inAddr_add(idexOut[127:96]),.inAddr_sl2(idexOut[31:0]*4),.outAddr(addBranchOut));
		muxtwo_32 mw32(.in1(idexOut[63:32]),.in2(idexOut[31:0]),.sl(ctrlUnitOutCode[7]),.out(mw32Out));
		ALU alu(.in1(idexOut[95:64]),.in2(mw32Out),.ctrl(aluctrl),.out(aluResult),.zero(zero));
		EXMEM exmem(.addBranch(addBranchOut),.aluZero(zero),.aluResult(aluResult),.readData2(idexOut[63:32]),.out(exmemOut),.clk(clk),.rst(rst));
		DM dm(.inAddr(aluResult),.writeData(exmemOut[31:0]),.memRead(ctrlUnitOutCode[4]),.memWrite(ctrlUnitOutCode[3]),.outData(dmOutData),.clk(clk));
		MEMWB memwb(.readData(dmOutData),.aluResult(exmemOut[63:32]),.out(memwbOut),.clk(clk),.rst(rst));
		AddBranch addBranch(.inAddr_add(pcPlus4),.inAddr_sl2(extSign32*4),.outAddr(addBranchOut));
		muxtwo_32 mw32_3(.in1(pcPlus4),.in2(addBranchOut),.sl(ctrlUnitOutCode[2]&zero),.out(branOrPc));
		SL2Add sl2Add(.in26(imOutData[25:0]),.in4(pcPlus4[31:28]),.out32(sl2AddOut));
		muxtwo_32 mw32_4(.in1(branOrPc),.in2(sl2AddOut),.sl(ctrlUnitOutCode[9]),.out(pcInputAddr));
		controlUnit controlunit(.inCode(imOutData[31:26]),.outCode(ctrlUnitOutCode));
		muxtwo_4 mw4(.in1(imOutData[20:16]),.in2(imOutData[15:11]),.sl(ctrlUnitOutCode[8]),.out(writeReg));//
		RegHeap regHeap(.readReg1(imOutData[25:21]),.readReg2(imOutData[20:16]),.writeReg(writeReg),.regWrite(ctrlUnitOutCode[5]),.writeData(writeData),.reg1Data(reg1Data),.reg2Data(reg2Data),.clk(clk));
		signExt signext(.in1(imOutData[15:0]),.out(extSign32));
		muxtwo_32 mw32(.in1(reg2Data),.in2(extSign32),.sl(ctrlUnitOutCode[7]),.out(mw32Out));
		ALUControl aluControl(.func(imOutData[5:0]),.aluop(ctrlUnitOutCode[1:0]),.aluctrl(aluctrl));
		ALU alu(.in1(reg1Data),.in2(mw32Out),.ctrl(aluctrl),.out(aluResult),.zero(zero));
		DM dm(.inAddr(aluResult),.writeData(reg2Data),.memRead(ctrlUnitOutCode[4]),.memWrite(ctrlUnitOutCode[3]),.outData(dmOutData),.clk(clk));
		muxtwo_32 mw32_2(.in1(aluResult),.in2(dmOutData),.sl(ctrlUnitOutCode[6]),.out(writeData));
		*/
endmodule