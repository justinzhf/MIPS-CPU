//pc?4????
module Add4 #(parameter WIDTH=32)(inAddr,outAddr);
  input[WIDTH-1:0] inAddr;
  output[WIDTH-1:0] outAddr;
  
  assign outAddr=inAddr+4;
  
endmodule
