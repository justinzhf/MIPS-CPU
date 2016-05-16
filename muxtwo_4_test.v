module muxtwo_4_test();
  reg[4:0] in1;
  reg[4:0] in2;
  reg sl;
  wire[4:0] out;
  
  muxtwo_4 test(.in1(in1),.in2(in2),.sl(sl),.out(out));
  
  initial
  begin
    in1=0;
    in2=1;
    sl=0;
    #10 sl=1;
    #10 sl=0;
    #10 sl=1;
    #10 sl=0;
  end
  
endmodule
