module ALU(in1,in2,ctrl,out);
  input[31:0] in1;
  input[31:0] in2;
  input[3:0] ctrl;
  input clk;
  reg[31:0] result;
  output[31:0] out;
  
  initial
  begin
    result=0;
  end
  
  
  always @(in1 or in2 or ctrl)
  begin
    case(ctrl)
    4'b0000:  result<=in1&in2;
    4'b0001:  result<=in1||in2;
    4'b0010:  result<=in1+in2;
    4'b0110:  result<=in1-in2;
    4'b0111:  result<=(in1<in2)?1:0;
    4'b1100:  result<=!(in1||in2);
    default:  result<=0;
  endcase
  end
  
  assign out=result;
  
  
endmodule
