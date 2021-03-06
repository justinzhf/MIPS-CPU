//module ALU(in1,in2,ctrl,out,clk);
module ALU_test();
  reg[31:0] in1,in2;
  reg[4:0] ctrl;
  wire[31:0] out;
  reg clk;
  
  ALU alu(.in1(in1),.in2(in2),.ctrl(ctrl),.out(out),.clk(clk));
  
  initial
  begin
    in1=3;
    in2=1;
    ctrl=0;
    clk=0;
  end
  
  always     #10 clk=~clk;
  
  always 
  begin
  #10 ctrl=4'b0001;//out=3
  #10 ctrl=4'b0010;//out=4
  #10 ctrl=4'b0110;//out=2
  #10 ctrl=4'b0111;//out=0
  #10 ctrl=4'b1100;//out=
  end
  
  
endmodule
