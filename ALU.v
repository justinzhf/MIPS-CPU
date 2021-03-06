module ALU(in1,in2,ctrl,out,zero,overflow);
  input[31:0] in1;
  input[31:0] in2;
  input[3:0] ctrl;
  input clk;
  reg[31:0] result;
  output[31:0] out;
  output zero,overflow;
  reg zero,overflow;
  
  initial
  begin
    zero<=0;
    overflow<=0;
  end
  
  
  always @(in1 or in2 or ctrl)
  begin
    case(ctrl)
    4'b0000:  result=in1&in2;
    4'b0001:  result=in1|in2;
    4'b0010:  result=in1+in2;
    4'b0110:  result=in1-in2;
    4'b0111:  result=(in1<in2)?1:0;
    4'b1100:  result=!(in1|in2);
    default:  result=0;
  endcase
    zero=(result==0)?1:0;
    if(in1[31]==0&&in2[31]==0&&result[31]==1&&ctrl==4'b0010)overflow<=1;
    if(in1[31]==1&&in2[31]==1&&result[31]==0&&ctrl==4'b0010)overflow<=1;
    if(in1[31]==0&&in2[31]==1&&result[31]==1&&ctrl==4'b0110)overflow<=1;
    if(in1[31]==1&&in2[31]==0&&result[31]==0&&ctrl==4'b0110)overflow<=1;
  end
  
  assign out=result;
  
  
endmodule
