module IM #(parameter WIDTH=32)(inAddr,outContent);
  reg[WIDTH-1:0] mem[255:0];//256?32?????????????
  input[WIDTH-1:0] inAddr;//????????
  output[WIDTH-1:0] outContent;//??????
  reg[WIDTH-1:0] content;
  
  integer i;
  
  initial
  begin
    $readmemh("memData.data",mem);
    for(i=0;i<8;i=i+1)
      $display(mem[i]);
  end
  assign outContent=mem[inAddr];
  
  
endmodule