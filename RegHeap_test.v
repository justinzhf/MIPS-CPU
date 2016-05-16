//module RegHeap(readReg1,readReg2,writeReg,regWrite,writeData,reg1Data,reg2Data,clk);
module RegHeap_test();
  reg clk;
  reg[4:0] readReg1;
  reg[4:0] readReg2;
  reg[4:0] writeReg;
  reg regWrite;
  reg[31:0] writeData;
  wire[31:0] reg1Data;
  wire[31:0] reg2Data; 
  
  RegHeap regheap(.readReg1(readReg1),.readReg2(readReg2),.writeReg(writeReg),.regWrite(regWrite),.writeData(writeData),.reg1Data(reg1Data),.reg2Data(reg2Data),.clk(clk));
  
  initial 
  begin
    clk=0;
    readReg1=0;
    readReg2=0;
    regWrite=1;
    
    writeReg=0;
    writeData=32'hbbbb_bbbb;//?????????,readReg1????????
    
  end
  
  always
  begin
    #10 clk=~clk;
  end
  
  always
  begin  
    #10 readReg2=readReg2+1;
  end
     
endmodule
