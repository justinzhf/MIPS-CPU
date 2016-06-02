`include"muxthree.v"
module mtt();
	reg[31:0] in1,in2,in3;
	reg[1:0] sl;
	wire[31:0] out;

	initial 
	begin
		$dumpfile("mt.vcd");
		$dumpvars;
		in1<=32'b01;
		in2<=32'b10;
		in3<=32'b11;
		sl<=2'b01;
	end

	muxthree mt(.in1(in1),.in2(in2),.in3(in3),.sl(sl),.out(out));
endmodule