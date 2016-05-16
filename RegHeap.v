module RegHeap(readReg1,readReg2,writeReg,regWrite,writeData,reg1Data,reg2Data,clk);
  input[4:0] readReg1;
  input[4:0] readReg2;
  input[4:0] writeReg;//
  input regWrite;//
  input[31:0] writeData;
  input clk;
  output[31:0] reg1Data;
  output[31:0] reg2Data;
  
  reg[31:0] mem[31:0];//????

  initial
  begin
    $readmemh("regHeapData.data",mem);
  end
  
  always @(posedge clk)
  begin
    if(regWrite)mem[writeReg]<=writeData;  
  end
  
   assign reg1Data=mem[readReg1];
   assign reg2Data=mem[readReg2];
  
endmodule