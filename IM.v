module IM #(parameter WIDTH=32)(inAddr,outContent);
  reg[7:0] mem[16383:0];//256?32?????????????
  input[WIDTH-1:0] inAddr;//????????
  output[WIDTH-1:0] outContent;//??????
  
  
  
  initial
  begin
    $readmemh("j.data",mem);
  end
  assign outContent={mem[inAddr+3],mem[inAddr+2],mem[inAddr+1],mem[inAddr]};
  
  
endmodule