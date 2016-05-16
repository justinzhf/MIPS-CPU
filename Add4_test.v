module Add4_test #(parameter WIDTH=32)();
  reg[WIDTH-1:0] inAddr_t;
  wire[WIDTH-1:0] outAddr_t;
  
  Add4 add4(.inAddr(inAddr_t),.outAddr(outAddr_t));
  
  initial
  begin
    inAddr_t=0;
    #10 inAddr_t=0;
    #10 inAddr_t=1;
    #10 inAddr_t=2;
    #10 inAddr_t=3;    
  end
  
   
endmodule
