//
module PC_test #(parameter WIDTH=32)();
  reg[WIDTH-1:0] inAddr_t;
  wire[WIDTH-1:0] outAddr_t;
  reg clock;
  PC temp(.inAddr(inAddr_t),.outAddr(outAddr_t),.clk(clock));
  
  initial 
  begin
    clock=0;
    inAddr_t=0;
  end
  
  always 
  begin
    #10 clock=~clock;
    #10 inAddr_t<=inAddr_t+1;
  end
  

endmodule
 