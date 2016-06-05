module PC #(parameter WIDTH=32) (inAddr,outAddr,clk,rst,PCWrite,overflow);
  input[WIDTH-1:0] inAddr;
  output[WIDTH-1:0] outAddr;
  input clk;
  input rst,overflow;
  input PCWrite;

  reg[31:0] outAddr;
  
  initial
  begin
    outAddr<=32'h0000_3000;
  end

  always @( posedge clk)
  begin
    if(rst==1)outAddr<=32'h0000_3000;
    else if(overflow)outAddr<=32'h0000_3600;
    else if(PCWrite==0);
    else outAddr<=inAddr;
  end
  
  //assign outAddr=con;
endmodule