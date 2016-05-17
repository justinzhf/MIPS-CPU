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
//`include"And.v"
module CPU(clk);
	input clk;
	reg[31:0] pcInputAddr; //type 'reg' for test

	wire[31:0] pcOutAddr;
	wire[31:0] imOutData;
	wire[8:0] ctrlUnitOutCode;

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


	//reg regWrite;//for test
	wire[31:0] writeData;//for test

/*	//to test DM read
	reg[31:0] dmAddr;
	wire[31:0] dmData;
	reg dmRead;
	reg dmWrite;
*/	
	//to test RegHeap
	reg[4:0] readReg1_t,readReg2_t;
	wire[31:0] reg1Data_t,reg2Data_t;
	reg writeReg_t;

	initial
	begin
/*	//to test DM read
		dmAddr=7;
		dmRead=1;
		dmWrite=1;
*/
		//to test RegHeap
		//readReg1_t=9;
		//writeReg_t=1;
		//regWrite=0;
	end
		
		PC pc(.inAddr(pcInputAddr),.outAddr(pcOutAddr),.clk(clk));
		Add4 add4(.inAddr(pcOutAddr),.outAddr(pcPlus4));
		AddBranch addBranch(.inAddr_add(pcPlus4),.inAddr_sl2(extSign32*4),.outAddr(addBranchOut));
		muxtwo_32 mw32_3(.in1(pcPlus4),.in2(addBranchOut),.sl(ctrlUnitOutCode[2]&zero),.out(branOrPc));
		//muxtwo_32 mw32_4(.in1(imOutData[25:0]*4+pcPlus4[31:28]),.in2(branOrPc),.sl(andOut),.out(mw32Out));
		IM im(.inAddr(pcOutAddr),.outContent(imOutData));//imOutData为读出的指令
		controlUnit controlunit(.inCode(imOutData[31:26]),.outCode(ctrlUnitOutCode));
		muxtwo_4 mw4(.in1(imOutData[20:16]),.in2(imOutData[15:11]),.sl(ctrlUnitOutCode[8]),.out(writeReg));//
		RegHeap regHeap(.readReg1(imOutData[25:21]),.readReg2(imOutData[20:16]),.writeReg(writeReg),.regWrite(ctrlUnitOutCode[5]),.writeData(writeData),.reg1Data(reg1Data),.reg2Data(reg2Data),.clk(clk));
		signExt signext(.in1(imOutData[15:0]),.out(extSign32));
		muxtwo_32 mw32(.in1(reg2Data),.in2(extSign32),.sl(ctrlUnitOutCode[7]),.out(mw32Out));
		ALUControl aluControl(.func(imOutData[5:0]),.aluop(ctrlUnitOutCode[1:0]),.aluctrl(aluctrl));
		ALU alu(.in1(reg1Data),.in2(mw32Out),.ctrl(aluctrl),.out(aluResult),.zero(zero));
		DM dm(.inAddr(aluResult),.writeData(reg2Data),.memRead(ctrlUnitOutCode[4]),.memWrite(ctrlUnitOutCode[3]),.outData(dmOutData),.clk(clk));
		muxtwo_32 mw32_2(.in1(aluResult),.in2(dmOutData),.sl(ctrlUnitOutCode[6]),.out(writeData));
endmodule