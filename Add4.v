//pc?4????
module Add4 (inAddr,outAddr);
  input[31:0] inAddr;
  output[31:0] outAddr;
  
  assign outAddr=inAddr+4;
  
endmodule
