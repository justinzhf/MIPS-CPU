`include"IM.v"
module IM_test #(parameter WIDTH=32)();
  reg[WIDTH-1:0] inAddr_t;
  wire[WIDTH-1:0] outContent_t;
  
  IM im(.inAddr(inAddr_t),.outContent(outContent_t));
  
  initial
  begin
  	$dumpfile("IM_test.vcd");
  	$dumpvars;
    #10 inAddr_t=0;
    #10 inAddr_t=1;
    #10 inAddr_t=2;
  end
    
  
  
endmodule
