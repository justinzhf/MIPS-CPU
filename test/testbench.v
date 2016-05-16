`include "tester.v"
`include "dff.v"
//Test bench connects the flip-flop to the tester module
module testbench;
	wire clk,d,q,qn;
	dff ff1(d,clk,q,qn);
	tester tst1(q,qn,clk,d);

endmodule
