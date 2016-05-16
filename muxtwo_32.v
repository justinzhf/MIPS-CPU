//32???????
module muxtwo_32(in1,in2,sl,out);
  input[31:0] in1;
  input[31:0] in2;  
  input sl;   //????????
  output[31:0] out;
  
  assign out=(sl==0)?in1:in2;
  
endmodule

