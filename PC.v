module PC #(parameter WIDTH=32) (inAddr,outAddr,clk,rst);
  input[WIDTH-1:0] inAddr;
  output[WIDTH-1:0] outAddr;
  reg[WIDTH-1:0] outAddr;
  input clk;
  input rst;

  reg[31:0] con;
  
  initial
  begin
    con=32'h0000_3000;
  end

  always @( rst or inAddr)
  begin
    if(rst==1)con=32'h0000_3000;
    else begin
     outAddr=con;
     #1 con=inAddr;
    end
  end
  
  //assign outAddr=con;
endmodule