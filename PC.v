module PC #(parameter WIDTH=32) (inAddr,outAddr,clk);
  input[WIDTH-1:0] inAddr;
  output[WIDTH-1:0] outAddr;
  reg[WIDTH-1:0] outAddr;
  input clk;
  reg[WIDTH-1:0] con;

  
  initial
  begin
    con<=0;
  end
  
  always @(posedge clk)
  begin
    outAddr<=inAddr;
  end
  
  //assign outAddr=con;
endmodule